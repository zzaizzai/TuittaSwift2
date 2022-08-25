//
//  Models.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/24.
//

import Foundation

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
    let time: Date
    var likes: Int
    
    var didLike: Bool = false
    
    var user: User?
    
    init(documentId: String, data: [String:Any] ) {
        self.documentId = documentId
        self.authorUid = data["authorUid"] as? String ?? "no authorUid"
        
        self.postText = data["postText"] as? String ?? "no postText"
        self.postImageUrl = data["postImageUrl"] as? String ?? "no postImageUrl"
        
        self.time = data["time"] as? Date ?? Date()
        self.likes = data["likes"] as? Int ?? 0
        
    }
}
