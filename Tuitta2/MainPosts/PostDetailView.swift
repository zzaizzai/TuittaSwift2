//
//  PostDetailView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

class PostDetailViewModel : ObservableObject {
    @Published var commentText = ""
    @Published var post: Post?
    
    @Published var didLike = false
    @Published var CountLikes = 0
    private let service = Service()
    
    init(post: Post?){
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
    
    
    
}

struct PostDetailView: View {
    
    var post : Post?
    @ObservedObject var vm : PostDetailViewModel
    @EnvironmentObject var auth : AuthViewModel
    
    init(post: Post?){
        self.post = post
        self.vm = PostDetailViewModel(post: post)
        
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
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
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
            
            HStack{
                
                Spacer()
                Image(systemName: "message")
                Text("0")
                Spacer()
                Image(systemName: "arrow.2.squarepath")
                Text("0")
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

                    Text(vm.CountLikes.description)
                }
                .foregroundColor(vm.didLike ? Color.red : Color.black)
                
                Spacer()
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
