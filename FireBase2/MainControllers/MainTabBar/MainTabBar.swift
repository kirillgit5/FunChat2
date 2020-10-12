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
}

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    
    private let user: UserInformation
    
    required init(user: UserInformation) {
        self.user = user
    }
    
    
}
