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
    
    
}
