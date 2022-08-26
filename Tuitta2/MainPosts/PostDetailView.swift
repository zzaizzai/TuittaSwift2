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
    
    init(post: Post?){
        self.post = post
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
                Text("Cancle")
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
        PostDetailView(post: nil)
            .environmentObject(AuthViewModel())
            .font(.body.bold())
    }
}
