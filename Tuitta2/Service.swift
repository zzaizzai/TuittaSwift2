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
    
    func checkDidLike(post: Post?, didLike: @escaping(Bool)->()) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        guard let post = post else { return }
        
        Firestore.firestore().collection("posts").document(post.id).collection("liked").document(userUid).getDocument { snpashot, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let _ = snpashot?.data() else {
                didLike(false)
                return
            }
            
            didLike(true)
            
        }
    }
    
    func likeThisPost(post: Post?, done: @escaping ()->()) {
        guard let post = post else { return }
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        
        let likeData = [
            "time" : Timestamp(),
            "postUid" : post.id,
            "userUid" : userUid
        ] as [String:Any]
        
        
        Firestore.firestore().collection("posts").document(post.id).collection("liked").document(userUid).setData(likeData) { error in
            if let error = error {
                print(error)
                return
            }
            
            done()
        }
        
    }
    
    func unlikeThosPost(post: Post?, done: @escaping () -> ()) {
        guard let post = post else { return }
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("posts").document(post.id).collection("liked").document(userUid).delete()
        
        done()
        
    }
    
    func checkCountLikes(post: Post?, likes: @escaping (Int) -> () ){
        guard let postUid = post?.id else { return }
        
        var likesCounts = 0
        
        Firestore.firestore().collection("posts").document(postUid).collection("liked").getDocuments { snpashot, error in
            if let error = error {
                print(error)
                return
            }
            
            snpashot?.documents.forEach({ doc in
                likesCounts += 1
            })
            
            likes(likesCounts)
        }
        
        
        
    }
    
    func countComments(post: Post?, comments: @escaping (Int)->()) {
        guard let postUid = post?.id else { return }
        
        var commentsCount = 0
        
        Firestore.firestore().collection("posts").document(postUid).collection("comments").getDocuments { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            snapshot?.documents.forEach({ doc in
                commentsCount += 1
            })
            
            comments(commentsCount)
        }
    }
    
}

