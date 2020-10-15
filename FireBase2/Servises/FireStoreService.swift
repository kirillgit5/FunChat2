//
//  FireStoreService.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 11.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class FireStroreService {
    
    static let shared = FireStroreService()
    private let dataBase = Firestore.firestore()
    
    
    private var usersReferense: CollectionReference  {
        return dataBase.collection("users")
    }
    
    private var currentUser: UserInformation!
    
    private init() {}
    
    func saveUserProfile(id: String, email: String, firstName: String, lastName: String, description: String, birthday: Date, sex: String, place: String, userImageString: String, completion: @escaping (Result<UserInformation, Error>) -> Void) {
        
        let user = UserInformation(firstName: firstName, lastName: lastName,
                                   avatarStringURL: userImageString, id: id,
                                   birthday: birthday, description: description,
                                   email: email,
                                   place: place, sex: sex)
        self.usersReferense.document(user.id).setData(user.dictionaryForSave) { (error) in
            if let error = error {
                return completion(.failure(error))
                
            } else {
                completion(.success(user))
            }
        }
    }
    
    func createChat(messageString: String, receiver: UserInformation, complition: @escaping (Result<UserChat, Error>) -> Void) {
        let receiverReference = dataBase.collection(["users", receiver.id, "activeChats"].joined(separator: "/"))
        let receiverUserChat = UserChat(username: currentUser.username, userImageString: currentUser.avatarStringURL, id: currentUser.id, lastMessage: messageString)
        let publisherUserChat = UserChat(username: receiver.username, userImageString: receiver.avatarStringURL, id: receiver.id, lastMessage: messageString)
        let publisherReference = dataBase.collection(["users", currentUser.id, "activeChats"].joined(separator: "/"))
        
        let message = MMessage(user: currentUser, content: messageString)
        
        
        let receiverMessageRef = receiverReference.document(currentUser.id).collection("messages")
        let publisherMessageRef = publisherReference.document(receiver.id).collection("messages")
        
        receiverReference.document(currentUser.id).setData(receiverUserChat.dictionaryForSave) { (error) in
            if let error  = error {
                complition(.failure(error))
                return
            }
            receiverMessageRef.addDocument(data: message.dictionaryForSave) { (error) in
                if let error = error {
                    complition(.failure(error))
                    return
                }
            }
            return
            
        }
        
        publisherReference.document(receiver.id).setData(publisherUserChat.dictionaryForSave) { (error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            publisherMessageRef.addDocument(data: message.dictionaryForSave) { (error) in
                if let error = error {
                    complition(.failure(error))
                    return
                }
            }
            
            complition(.success(publisherUserChat))
            return
        }
        
    }
    
    func getUserInformation(user: User, completion: @escaping (Result<UserInformation, Error>) -> Void ) {
        let userDocReference = usersReferense.document(user.uid)
        userDocReference.getDocument {[unowned self] (document, error) in
            if let document = document, document.exists {
                guard let userInformation = UserInformation(document: document) else {  completion(.failure(UserError.canNotConvertToUSerInformation)) ; return }
                self.currentUser = userInformation
                completion(.success(userInformation))
            } else {
                completion(.failure(UserError.userDidNotFinishRegistration))
            }
        }
    }
    
    func isChatAlredyExist(user: UserInformation, completion: @escaping (Result<Void, UserError>) -> Void) {
        let receiverReference = dataBase.collection(["users", currentUser.id, "activeChats"].joined(separator: "/")).document(user.id)
        receiverReference.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let _ = UserChat(document: document) else {  completion(.failure(UserError.canNotConvertToUSerInformation)) ; return }
                completion(.success(Void()))
            } else {
                completion(.failure(UserError.userDidNotHaveChat))
            }
        }
    }
    
    func sendMessage(user: UserInformation, message: MMessage, completion: @escaping (Result<Void, Error>) -> Void) {
        let friendRef = usersReferense.document(user.id).collection("activeChats").document(currentUser.id)
        let friendMessageRef = friendRef.collection("messages")
        let myChatRef = usersReferense.document(currentUser.id).collection("activeChats").document()
        let myMessageRef = usersReferense.document(currentUser.id).collection("activeChats").document(user.id).collection("messages")
        let chatForFriend = UserChat(username: currentUser.username, userImageString: currentUser.avatarStringURL, id: currentUser.id, lastMessage: message.content)
        let chatForCurrentUSer = UserChat(username: user.username, userImageString: user.avatarStringURL, id: user.id, lastMessage: message.content)
        friendRef.setData(chatForFriend.dictionaryForSave) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            myChatRef.setData(chatForCurrentUSer.dictionaryForSave) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                friendMessageRef.addDocument(data: message.dictionaryForSave) { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    myMessageRef.addDocument(data: message.dictionaryForSave) { (error) in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        completion(.success(Void()))
                    }
                }
                
                
            }
        }
    }
    
    func sendMessage(user: UserChat, message: MMessage, completion: @escaping (Result<Void, Error>) -> Void) {
        let friendRef = usersReferense.document(user.id).collection("activeChats").document(currentUser.id)
        let friendMessageRef = friendRef.collection("messages")
        let myChatRef = usersReferense.document(currentUser.id).collection("activeChats").document()
        let myMessageRef = usersReferense.document(currentUser.id).collection("activeChats").document(user.id).collection("messages")
        let chatForFriend = UserChat(username: currentUser.username, userImageString: currentUser.avatarStringURL, id: currentUser.id, lastMessage: message.content)
        let chatForCurrentUSer = UserChat(username: user.username, userImageString: user.userImageString, id: user.id, lastMessage: message.content)
        friendRef.setData(chatForFriend.dictionaryForSave) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            myChatRef.setData(chatForCurrentUSer.dictionaryForSave) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                friendMessageRef.addDocument(data: message.dictionaryForSave) { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    myMessageRef.addDocument(data: message.dictionaryForSave) { (error) in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        completion(.success(Void()))
                    }
                }
                
                
            }
        }
    }
    
    
    
    
    
}
