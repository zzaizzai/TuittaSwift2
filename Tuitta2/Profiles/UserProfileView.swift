//
//  UserProfileView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/28.
//

import SwiftUI
import Firebase

class UserProfileViewModel : ObservableObject {
    
    @Published var user : User?
    
    @Published var userPosts = [Post]()
    let service = Service()
    
    
    init(user: User?){
        self.user = user
        self.getUsersPosts(user: user)
    }
    
    func getUsersPosts(user: User?) {
        guard let user = user else {
            return
        }

        Firestore.firestore().collection("posts").whereField("authorUid", isEqualTo: user.uid ).order(by: "time").getDocuments { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            snapshot?.documents.forEach({ doc in
                let docId = doc.documentID
                let data = doc.data()
                
                self.userPosts.insert(.init(documentId: docId, data: data), at: 0)
            })
            
            for i in 0 ..< self.userPosts.count {
                let userUid = self.userPosts[i].authorUid
                
                
                self.service.getUserData(userUid: userUid) { userData in
                    self.userPosts[i].user = userData
                }
            }
        }
        
    }
}


struct UserProfileView: View {
    @ObservedObject var vm : UserProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    init(user: User?){
        self.vm = UserProfileViewModel(user: user)
        
    }
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 0) {
                HStack{
                    ProfileImageView(user: vm.user)
                    Spacer()
                    
                    
                    //Todo: navigationlink to chat message
                    Image(systemName: "envelope")
                        .foregroundColor(Color.white)
                        .frame(width: 35, height: 35)
                        .background(Color.blue)
                        .cornerRadius(100)

                }
                .padding()
                
                VStack(alignment: .leading){
                    Text(vm.user?.name ?? "name")
                        .font(.system(size: 25))
                    Text(vm.user?.email ?? "email@test.com")
                        .foregroundColor(Color.gray)
                    
                    HStack{
                        Text("Join Date:")
                        Text(vm.user?.joinDate.dateValue() ?? Date(), style: .date)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                Divider()
                
                
                //showing user posts
                
                ForEach(vm.userPosts){ post in
                    PostRowView(post: post)
                }
                
                PostRowView(post: nil)
            }
            
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .top) {
            topview
        }
        
    }
    
    private var topview: some View {
        ZStack {            
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
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            UserProfileView(user: nil)
        }
    }
}
