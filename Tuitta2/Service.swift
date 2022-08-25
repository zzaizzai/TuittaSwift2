//
//  Service.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/25.
//

import Foundation
import Firebase


struct Service {
    
    func getUserData(userUid: String, done: @escaping (User)->() ) {
        
        Firestore.firestore().collection("users").document(userUid).getDocument { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let docId = snapshot?.documentID else { return }
            guard let data = snapshot?.data() else { return }
            
            let user = User(documentId: docId, data: data)
            
            done(user)
        }
    }
}

