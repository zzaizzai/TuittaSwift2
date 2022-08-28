//
//  PostDetailView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

class PostDetailViewModel : ObservableObject {
    @Published var commentText = ""
    @Published var post: Post?
    
    @Published var comments = [Comment]()
    
    @Published var didLike = false
    @Published var CountLikes = 0
    private let service = Service()
    
    
    init(post: Post?){
        self.getCommentsData(post: post)
        self.post = post
        self.checkDidLike(post: post)
        self.checkLikesCount(post: post)

        
    }
    
    func checkDidLike(post: Post?) {
        self.service.checkDidLike(post: self.post) { didLike in
            if didLike {
                self.didLike = true
            }
            else {
                self.didLike = false
            }
        }
    }
    
    func checkLikesCount(post: Post?) {
        self.service.checkCountLikes(post: post) { likesCount in
            self.CountLikes = likesCount
        }
    }
    
    func unlikeThisPost(post: Post?){
        self.service.unlikeThosPost(post: post) {
            print("unlike done")
            self.didLike = false
            self.CountLikes += -1
        }
        
    }
    
    func likethisPost(post: Post?) {
        self.service.likeThisPost(post: post) {
            print("like done")
            self.didLike = true
            self.CountLikes += 1
        }
    }
    
    
    func getCommentsData(post: Post?) {
        guard let post = post else {
            return
        }
        
        Firestore.firestore().collection("posts").document(post.id).collection("comments").order(by: "time").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            snapshot?.documentChanges.forEach({ doc in
                let docId = doc.document.documentID
                let data = doc.document.data()
                
                if doc.type == .added {
                    self.comments.append(.init(documentId: docId, data: data))
                }
                
                
            })
            
            for i in 0 ..< self.comments.count {
                self.service.getUserData(userUid: self.comments[i].userUid) { userData in
                    self.comments[i].user = userData
                }
            }
        }
        
    }
    
    
    func writeComment() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        guard let post = self.post else { return }
        
        let data = [
            "commentText": self.commentText,
            "postUid": post.id,
            "time": Timestamp(),
            "userUid": userUid,
        ] as [String:Any]
        
        
        Firestore.firestore().collection("posts").document(post.id).collection("comments").document().setData(data) { error in
            if let error = error {
                print(error)
                return
            }
            
            self.commentText = ""
        }
    }
    
}

struct PostDetailView: View {
    
    var post : Post?
    @ObservedObject var vm : PostDetailViewModel
    @EnvironmentObject var auth : AuthViewModel
    
    @State var showLikedUsers = false
    
    init(post: Post?){
        self.post = post
        self.vm = PostDetailViewModel(post: post)
        
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ScrollView{
                ZStack(alignment: .topTrailing) {
                    
                    if auth.currentUser?.uid == vm.post?.authorUid {
                        menuOfPost
                    } else {
                        if self.showMenuOfPost {
                            Text("it is not your post")
                                .padding(.trailing, 40)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack{
                            
                            ProfileImageView(user: vm.post?.user)
                            
                            VStack(alignment: .leading) {
                                HStack{
                                    Text(self.post?.user?.name ?? "name")
                                    Spacer()
                                    
                                    Text("...")
                                        .onTapGesture {
                                            withAnimation(.easeIn(duration: 0.2)) {
                                                self.showMenuOfPost.toggle()
                                            }
                                        }
                                }
                                Text(self.post?.user?.email ?? "email")
                            }
                            
                            
                        }
                        
                        Text(self.post?.postText ?? "content content content content content content")
                            .font(.title2.bold())
                        
                        HStack{
                            
                            Spacer()
                            
                            if let postimageurl = self.post?.postImageUrl {
                                if postimageurl.count > 30 {
                                    WebImage(url: URL(string: postimageurl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 300, height: 300)
                                        .cornerRadius(20)
                                        .onTapGesture {
                                        }
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                }
                
                HStack{
                    Text(vm.post?.time.dateValue() ?? Date() , style: .time)
                    Text(vm.post?.time.dateValue() ?? Date() , style: .date)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack{
                    Text("likes: \(vm.CountLikes.description)")
                        .onTapGesture {
                            self.showLikedUsers.toggle()
                        }
                    
                    
                    NavigationLink("" ,isActive: $showLikedUsers) {
                        PostLikedUsersView(post: vm.post)
                    }
                    
                    // Todo: show users who are liked it when you tap this
                    
                    
                    
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                
                Divider()
                
                
                //buttons
                HStack{
                    
                    Spacer()
                    Image(systemName: "message")
                    //                Text("0")
                    Spacer()
                    Image(systemName: "arrow.2.squarepath")
                    //                Text("0")
                    Spacer()
                    Button {
                        if vm.didLike {
                            vm.unlikeThisPost(post: vm.post)
                        } else {
                            vm.likethisPost(post: vm.post)
                        }
                    } label: {
                        ZStack{
                            Image(systemName: vm.didLike ? "heart.fill" : "heart")
                                .zIndex(vm.didLike ? 0 : 1)
                            
                        }
                        
                        //                    Text(vm.CountLikes.description)
                    }
                    .foregroundColor(vm.didLike ? Color.red : Color.black)
                    
                    Spacer()
                }
                .padding(.vertical, 5)
                
                Divider()
                
                ForEach(vm.comments){ comment in
                    CommentRowView(comment: comment)
                }
                
            }
            .navigationBarHidden(true)
            .safeAreaInset(edge: .top, content: {
                topview
            })
            .safeAreaInset(edge: .bottom) {
                bottomview
        }
        }
    }
    
    @State private var showMenuOfPost = false
    private var menuOfPost : some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Delete")
                .foregroundColor(Color.red)
            
            
            Text("Do nothing")
                .onTapGesture {
                    self.showMenuOfPost = false
                }
        }
        .padding()
        .background(Color.init(white: 0.7))
        .cornerRadius(20)
        .padding(.trailing, 50)
        .zIndex(1)
        .offset(x: self.showMenuOfPost ?  0 : 500 )
        
    }
    
    
    
    
    private var topview: some View {
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .padding()
                    .foregroundColor(Color.black)
            }
            
            Spacer()
            
            
        }
        .frame(height: 40)
        .background(Color.init(white: 0.9).opacity(0.8))
    }
    private var bottomview : some View {
        
        HStack{
            TextField("comment", text: $vm.commentText)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(Color.init(white: 0.8))
                .cornerRadius(30)
                .padding()
            
            Button {
                vm.writeComment()
            } label: {
                Image(systemName: "paperplane.fill")
                    .padding(.horizontal)
            }
            
            
        }
        .background(Color.init(white: 0.95))
        
        
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        PostDetailView(post: nil)
        MainPostsView()
            .environmentObject(AuthViewModel())
            .font(.body.bold())
    }
}
