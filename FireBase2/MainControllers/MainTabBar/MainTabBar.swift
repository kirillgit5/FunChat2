//
//  MainTabBar.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 12.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

protocol MainTabBarViewModelProtocol {
    init(user: UserInformation)
    func getUsersViewModel() -> UsersViewModelProtocol
    func getCurrentUser() -> UserInformation
}

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    
    
    private let user: UserInformation
    
    required init(user: UserInformation) {
        self.user = user
    }
    
    func getUsersViewModel() -> UsersViewModelProtocol {
        UsersViewModel(user: user)
    }
    
    func getCurrentUser() -> UserInformation {
        user
    }
    
}
