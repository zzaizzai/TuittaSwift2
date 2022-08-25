//
//  AuthViewModel.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import Foundation
import Firebase


class AuthViewModel : ObservableObject {
    @Published var isLoggedOut = true
    
    @Published var currentUser : User?
    
    @Published var userSession : FirebaseAuth.User?
    
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUserData { _ in
        }
    }
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            self.fetchUserData { done in
                if done {
                    self.isLoggedOut = false
                }
            }
        }
    }
    
    
    func fetchUserData(done: @escaping(Bool)->()) {
        guard let myUid = self.userSession?.uid else { return }
        Firestore.firestore().collection("users").document(myUid).getDocument { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let documentId = snapshot?.documentID else { return }
            guard let data = snapshot?.data() else { return }
            
            self.currentUser = User(documentId: documentId, data: data)
            
            done(true)
            
        }
    }
    
    func logOut(){
        
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
}
