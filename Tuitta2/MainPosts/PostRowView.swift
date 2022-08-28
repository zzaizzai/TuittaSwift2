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
    
    @Published var countLikes : Int = 0
    @Published var countComments : Int = 0
    
    
    init(post: Post?){
        self.post = post
        self.checkDidLike(post: post)
        self.countLikes(post: post)
        self.countComments(post: post)
        
    }
    
    func likeThisPost(post: Post?) {
        self.service.likeThisPost(post: post) {
            print("like done")
//            self.countLikes += 1
        }
        
    }
    
    func unlikeThosPost(post: Post?) {
        self.service.unlikeThosPost(post: post) {
            print("unlike done")
//            self.countLikes += -1
        }
        
    }
    
    
    func checkDidLike(post: Post?) {
        self.service.checkDidLike(post: post) { didLike in
            if didLike {
                self.didLike = true
            } else {
                self.didLike = false
                
            }
        }
    }
    
    func countLikes(post: Post?){
        self.service.checkCountLikes(post: post) { likes in
            self.countLikes = likes
        }
        
        
    }
    
    func countComments(post: Post?) {
        self.service.countComments(post: post) { countComments in
            self.countComments = countComments
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
    
    
    @State private var showImagefullscreen = false
    @State private var showDetail = false
    var body: some View {
        ZStack {

            HStack(alignment: .top){
                
                ProfileImageView(user: vm.post?.user)
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
                        Text(vm.countComments.description)
                        Spacer()
                        Image(systemName: "arrow.2.squarepath")
                        Text("0")
                        Spacer()
                        Button {
                            if vm.didLike {
                                vm.unlikeThosPost(post: vm.post)
                            } else {
                                vm.likeThisPost(post: vm.post)
                            }
                        } label: {
                            ZStack{
                                Image(systemName: vm.didLike ? "heart.fill" : "heart")
                                    .zIndex(vm.didLike ? 0 : 1)
                                
                            }

                            Text(vm.countLikes.description)
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
