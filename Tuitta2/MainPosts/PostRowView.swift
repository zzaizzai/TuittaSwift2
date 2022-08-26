//
//  PostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

class PostRowViewModel : ObservableObject {
    @Published var post : Post?
    let service = Service()
    
    @Published var didLike : Bool = false
    @Published var comments : Int = 0
    @Published var rePost = false
    
    @Published var CountLikes : Int = 0
    @Published var CountComments : Int = 0
    
    
    init(post: Post?){
        self.post = post
        self.checkDidLike(post: post)
        self.countLikes(post: post)
        self.countComments(post: post)
        
    }
    

    func checkDidLike(post: Post?) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        guard let post = post else { return }
        
        Firestore.firestore().collection("posts").document(post.id).collection("liked").document(userUid).getDocument { snpashot, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let _ = snpashot?.data() else {
                self.didLike = false
                return
            }
            
            self.didLike = true
            
        }
    }
    
    func countLikes(post: Post?){
        guard let postUid = post?.id else { return }
        
        Firestore.firestore().collection("posts").document(postUid).collection("liked").getDocuments { snpashot, error in
            if let error = error {
                print(error)
                return
            }
            
            snpashot?.documents.forEach({ doc in
                self.CountLikes += 1
            })
        }
        
        
        
    }
    
    func countComments(post: Post?) {
        guard let postUid = post?.id else { return }
        
        Firestore.firestore().collection("posts").document(postUid).collection("comments").getDocuments { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            snapshot?.documents.forEach({ doc in
                self.CountComments += 1
            })
        }
    }

    

}

struct PostRowView : View {
    
    @EnvironmentObject var page: PageControl
    @ObservedObject var vm : PostRowViewModel
    @State var showPostDetail = false
    
    init(post : Post?){
        self.vm = PostRowViewModel(post: post)
    }
    
    
    
    @State private var showDetail = false
    var body: some View {
        HStack(alignment: .top){
            
            ProfileImageView(profileImageUrl: vm.post?.user?.profileImageUrl ?? nil)
//            post?.user?.profileImageUrl
            
            VStack(alignment: .leading) {
                HStack{
                    Text(vm.post?.user?.name ?? "name")
                    Text(vm.post?.user?.email ?? "email")
                        .foregroundColor(Color.gray)
                    
                    Spacer()

                }
                Text(vm.post?.postText ?? "text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text")
                
                //show image
                if let postimageurl = vm.post?.postImageUrl {
                    if postimageurl.count > 30 {
                        WebImage(url: URL(string: postimageurl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .cornerRadius(20)
                    }
                }
                
                Group{
                    HStack{
                        Text(vm.post?.time.dateValue() ?? Date(), style: .date)
                        Text(vm.post?.time.dateValue() ?? Date(), style: .time)
                    }
                }
                .font(.system(size: 12))
                .foregroundColor(Color.gray)
                
                HStack{
                    Image(systemName: "message")
                    Text(vm.CountComments.description)
                    Spacer()
                    Image(systemName: "arrow.2.squarepath")
                    Text("0")
                    Spacer()
                    Button {
                        vm.didLike.toggle()
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
            
            Spacer()
            
            
            NavigationLink("", isActive: $showPostDetail) {
                PostDetailView(post: vm.post)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.init(white: 0.9))
        .overlay(Rectangle().frame(height: 1).foregroundColor(.init(white: 0.8)), alignment: .bottom)
        .overlay(Rectangle().frame(height: 1).foregroundColor(.init(white: 0.8)), alignment: .top)
        .onTapGesture {
            self.showPostDetail = true
            
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
//            PostRowView(post: nil)
            ContentView()
                .environmentObject(PageControl())
                .environmentObject(AuthViewModel())
            .font(.body.bold())
//        }
    }
}
