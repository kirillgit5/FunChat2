//
//  UsersViewModel.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 13.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import FirebaseFirestore


protocol UsersViewModelProtocol {
    var users: Box<[UserInformation]> { get }
    init(user: UserInformation)
}

class UsersViewModel: UsersViewModelProtocol {
    
    var users: Box<[UserInformation]> = Box(value: [UserInformation]())
    
    private let user: UserInformation
    private var listener: ListenerRegistration?
    private let listenerService = ListenerService.shared
    
    
    required init(user: UserInformation) {
        self.user = user
        listener = listenerService.usersObserve(users: users.value, userId: user.id, complition: {[unowned self] (result) in
            switch result {
            case .success(let users):
                self.users.value = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    deinit {
        listener?.remove()
    }
    
    
}
