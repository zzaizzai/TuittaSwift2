//
//  PostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI
import Firebase

class PostRowViewModel : ObservableObject {
    @Published var post : Post?
    let service = Service()
    
    @Published var didLike : Bool = false
    @Published var comments : Int = 0
    @Published var rePost = false
    
    
    init(post: Post?){
        self.post = post
        self.checkDidLike(post: post)
        
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

    

}

struct PostRowView : View {
    
    @EnvironmentObject var page: PageControl
    @ObservedObject var vm : PostRowViewModel
    @State var showPostDetail = false
    
    var post : Post?
    
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
                }
                Text(vm.post?.postText ?? "text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text")
                
                HStack{
                    Image(systemName: "message")
                    Text("22")
                    Spacer()
                    Image(systemName: "arrow.2.squarepath")
                    Text("22")
                    Spacer()
                    Button {
                        vm.didLike.toggle()
                    } label: {
                        ZStack{
                            Image(systemName: vm.didLike ? "heart.fill" : "heart")
                                .zIndex(vm.didLike ? 0 : 1)
                            
                        }

                        Text("22")
                    }
                    .foregroundColor(vm.didLike ? Color.red : Color.black)

                    


                    Spacer()
                }
                
            }
            
            Spacer()
            
            
            NavigationLink("", isActive: $showPostDetail) {
                Text("show detail page")
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
        NavigationView {
            PostRowView(post: nil)
                .environmentObject(PageControl())
            .font(.body.bold())
        }
    }
}
