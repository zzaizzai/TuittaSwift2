//
//  PostLikedUsersView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/28.
//

import SwiftUI
import Firebase

class PostLikedUsersViewModel : ObservableObject {
    
    @Published var users  = [User]()
    let service = Service()
    
    
    init(post: Post?) {
        self.getUsersData(post: post)
    }


    func getUsersData(post: Post?) {
        
        guard let post = post else {
            return
        }
        
        var userUid = [String]()

        Firestore.firestore().collection("posts").document(post.id).collection("liked").getDocuments { snapshot, erorr in
            if let erorr = erorr {
                print(erorr)
                return
            }
            
            snapshot?.documents.forEach({ doc in
                let docId = doc.documentID
                
                userUid.insert( docId , at: 0)
            })
            
            for i in 0 ..< userUid.count {
                self.service.getUserData(userUid: userUid[i]) { userData in
                    self.users.insert(userData, at: 0)
                }
            }
        }
        
        

    }
    
}

struct PostLikedUsersView: View {
    
    @ObservedObject var vm  : PostLikedUsersViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(post: Post?){
        self.vm = PostLikedUsersViewModel(post: post)
        
    }
    var body: some View {
        VStack {
            ScrollView {
                ForEach(vm.users){ user in
                    UserRowView(user: user)
//                    Text(user)
                }
            }
        }
        .safeAreaInset(edge: .top) {
            topview
        }
        .navigationBarHidden(true)
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
            
            Text("who liked")
                .offset(x: -20)
            
            Spacer()
            
            
        }
        .frame(height: 40)
        .background(Color.init(white: 0.9).opacity(0.8))
    }
}

struct PostLikedUsersView_Previews: PreviewProvider {
    static var previews: some View {
        PostLikedUsersView(post: nil)
    }
}
