//
//  Models.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct User: Identifiable, Codable {
    var id: String {documentId}
    
    let documentId: String
    let uid, name, email, profileImageUrl, profileText: String
    let joinDate: Date
    var following, follower : Int
    
    init(documentId: String, data: [String:Any]) {
        self.documentId = documentId
        self.uid = data["uid"] as? String ?? "no"
        self.email = data["email"] as? String ?? "no email"
        self.name = data["name"] as? String ?? "no name"
        self.profileImageUrl = data["profileImageUrl"] as? String ?? "no profileImageUrl"
        self.profileText = data["profileText"] as? String ?? "no profileText"
        self.joinDate = data["joinDate"] as? Date ?? Date()
        self.following = data["following"] as? Int ?? 0
        self.follower = data["follower"] as? Int ?? 0
    }
}

struct Post: Identifiable, Codable {
    
    var id : String { documentId }
    
    let documentId: String
    let authorUid : String
    let postImageUrl, postText: String
    let time: Timestamp
    
    
    var user: User?
    
    init(documentId: String, data: [String:Any] ) {
        self.documentId = documentId
        self.authorUid = data["authorUid"] as? String ?? "no authorUid"
        
        self.postText = data["postText"] as? String ?? "no postText"
        self.postImageUrl = data["postImageUrl"] as? String ?? "no postImageUrl"
        
        self.time = data["time"] as? Timestamp ?? Timestamp()
        
    }
}


struct Comment: Identifiable, Codable {
    
    var id: String {documentId}
    
    let documentId: String
    let userUid, postUid, commentText: String
    let time: Timestamp
    
    var liked : Bool = false
    
    var user : User?
    
    init(documentId: String, data: [String:Any]) {
        self.documentId = documentId
        self.userUid = data["userUid"] as? String ?? "no userUid"
        self.postUid = data["postUid"] as? String ?? "no postUid"
        self.commentText = data["commentText"] as? String ?? "no commentText"
        
        self.time = data["time"] as? Timestamp ?? Timestamp()
        
    }
}
