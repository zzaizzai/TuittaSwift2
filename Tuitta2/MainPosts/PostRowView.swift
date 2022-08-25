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
    
    var didLike = false
    var comments : Int = 0
    var rePost = false
    
    
    init(post: Post?){
        self.post = post
        self.fetchDidLike(post: post)
        
    }
    

    func fetchDidLike(post: Post?) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        guard let post = post else { return }
        
        Firestore.firestore().collection("posts").document(post.id).collection("liked").document(userUid).getDocument { snpashot, error in
            if let error = error {
                print(error)
                return
            }
            
            if let doc = snpashot {
                print("liked \(doc.documentID)")
                self.didLike = true
            }
            
        }
    }

    

}

struct PostRowView : View {
    
    @EnvironmentObject var page: PageControl
    @ObservedObject var vm : PostRowViewModel
    
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
                    Image(systemName: "heart")
                    Text("22")
                    Spacer()
                }
                
            }
            
            Spacer()
            
            
            NavigationLink("", isActive: $page.showDetailIndex0) {
                Text("show detail page")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.init(white: 0.9))
        .overlay(Rectangle().frame(height: 1).foregroundColor(.init(white: 0.8)), alignment: .bottom)
        .overlay(Rectangle().frame(height: 1).foregroundColor(.init(white: 0.8)), alignment: .top)
        .onTapGesture {
            page.showDetailIndex0 = true
            
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
