//
//  UserChat.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 03.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct UserChat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: String
    
    var dictionaryForSave: [String : Any] {
           var dictionary: [String: Any] = [:]
           dictionary["username"] = username
           dictionary["userImageString"] = userImageString
           dictionary["lastMessage"] = lastMessage
           dictionary["uid"] = id
           return dictionary
           
       }
    
    init(username: String, userImageString: String, id: String, lastMessage: String) {
        self.username = username
        self.userImageString = userImageString
        self.id = id
        self.lastMessage = lastMessage
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let username = data["username"] as? String,
        let userImageString = data["userImageString"] as? String,
        let id = data["uid"] as? String,
        let lastMessage = data["lastMessage"] as? String else { return nil }
        
        self.username = username
        self.userImageString = userImageString
        self.id = id
        self.lastMessage = lastMessage
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else {  return nil }
           guard let username = data["username"] as? String,
           let userImageString = data["userImageString"] as? String,
           let id = data["uid"] as? String,
           let lastMessage = data["lastMessage"] as? String else { return nil }
           
           self.username = username
           self.userImageString = userImageString
           self.id = id
           self.lastMessage = lastMessage
       }
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UserChat, rhs: UserChat) -> Bool {
        lhs.id == rhs.id
    }
}
