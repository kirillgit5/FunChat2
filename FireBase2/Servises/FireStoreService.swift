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
    
    func getUserInformation(user: User, completion: @escaping (Result<UserInformation, Error>) -> Void ) {
        let userDocReference = usersReferense.document(user.uid)
        userDocReference.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let userInformation = UserInformation(document: document) else {  completion(.failure(UserError.canNotConvertToUSerInformation)) ; return }
                completion(.success(userInformation))
            } else {
                completion(.failure(UserError.userDidNotFinishRegistration))
            }
        }
    }
    
    
    
}
