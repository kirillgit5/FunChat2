//
//  MMessage.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 14.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct MMessage: Hashable, MessageType {
   
    var sender: SenderType
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKind {
        return .text(content)
    }
    
    let content: String
    
    let sentDate: Date
    var id: String?
    
    
    
    init(user: UserInformation, content: String) {
        sender = Sender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        self.content = content
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderId"] as? String else {  return nil }
        guard let senderUsername = data["senderName"] as? String  else { return nil }
        guard let content = data["content"]  as? String else { return nil }
        
        self.sentDate = sentDate.dateValue()
        self.id = document.documentID
        sender = Sender(senderId: senderId, displayName: senderUsername)
        self.content = content
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderId"] as? String else {  return nil }
        guard let senderUsername = data["senderName"] as? String  else { return nil }
        guard let content = data["content"]  as? String else { return nil }
        
        self.sentDate = sentDate.dateValue()
        self.id = document.documentID
        sender = Sender(senderId: senderId, displayName: senderUsername)
        self.content = content
    }
    
    var dictionaryForSave: [String : Any] {
        var dictionary: [String: Any] = [:]
        dictionary["content"] = content
        dictionary["senderId"] = sender.senderId
        dictionary["senderName"] = sender.displayName
        dictionary["created"] = Timestamp(date: sentDate)
        return dictionary
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
       }
    
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

