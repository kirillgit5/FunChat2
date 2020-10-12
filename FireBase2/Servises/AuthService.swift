//
//  NetworkService.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 10.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


class AuthService {
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void ) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {  completion(.failure(error!))
                return
            }
            completion(.success(result.user))
            return
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {  completion(.failure(error!))
                return
            }
            completion(.success(result.user))
            return
        }
    }
    
    
}

