//
//  ListenerService.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 13.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ListenerService {
    static let shared = ListenerService()
    
    private let dataBase = Firestore.firestore()
    
    private var usersReferense: CollectionReference  {
        return dataBase.collection("users")
    }
    
    private var currentUserId: String {
           return Auth.auth().currentUser!.uid
       }
    
    
    private init() {}
    
    func usersObserve(users: [UserInformation], userId: String, complition: @escaping (Result<[UserInformation], Error>) -> Void) -> ListenerRegistration {
        var usersForEditing = users
        let userListener = usersReferense.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { complition(.failure(error!)) ; return }
            snapshot.documentChanges.forEach { (diff) in
                guard let user = UserInformation(document: diff.document) else { return }
                switch diff.type {
                    
                case .added:
                    guard !users.contains(user), user.id != userId else { return }
                    usersForEditing.append(user)
                    complition(.success(usersForEditing))
                    
                case .modified:
                    return
                    
                case .removed:
                    return
                    
                }
            }
        }
        return userListener
    }
    
    func messagesObserve(userId: String, completion: @escaping (Result<MMessage, Error>) -> Void) -> ListenerRegistration? {
        let ref = usersReferense.document(currentUserId).collection("activeChats").document(userId).collection("messages")
         let messagesListener = ref.addSnapshotListener { (querySnapshot, error) in
             guard let snapshot = querySnapshot else {
                 completion(.failure(error!))
                 return
             }
             
             snapshot.documentChanges.forEach { (diff) in
                 guard let message = MMessage(document: diff.document) else { return }
                 switch diff.type {
                 case .added:
                     completion(.success(message))
                 case .modified:
                     break
                 case .removed:
                     break
                 }
             }
         }
         return messagesListener
     }
    
    
    func activeChatsObserve(chats: [UserChat], completion: @escaping (Result<[UserChat], Error>) -> Void) -> ListenerRegistration? {
           var chats = chats
           let chatsRef = dataBase.collection(["users", currentUserId, "activeChats"].joined(separator: "/"))
           let chatsListener = chatsRef.addSnapshotListener { (querySnapshot, error) in
               guard let snapshot = querySnapshot else {
                   completion(.failure(error!))
                   return
               }
               snapshot.documentChanges.forEach { (diff) in
                   guard let chat = UserChat(document: diff.document) else { return }
                   switch diff.type {
                   case .added:
                       guard !chats.contains(chat) else { return }
                       chats.append(chat)
                   case .modified:
                       guard let index = chats.firstIndex(of: chat) else { return }
                       chats[index] = chat
                   case .removed:
                       guard let index = chats.firstIndex(of: chat) else { return }
                       chats.remove(at: index)
                   }
               }
               
               completion(.success(chats))
           }
           return chatsListener
       }
}

