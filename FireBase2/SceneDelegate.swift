//
//  SceneDelegate.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 20.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        if let user = Auth.auth().currentUser {
            FireStroreService.shared.getUserInformation(user: user) {[unowned self] (result) in
                switch result {
                case .success(let userInformation):
                    let mainTabBarViewModel = MainTabBarViewModel(user: userInformation)
                    self.window?.rootViewController = MainTabBarController(viewModel: mainTabBarViewModel)
                    self.window?.makeKeyAndVisible()
                case .failure(_ :):
                    let viewModel = SetupProfileViewModel(currentUser: user)
                    let setupProfileVC = SetupProfileViewController(viewModel: viewModel)
                    self.window?.rootViewController = setupProfileVC
                    self.window?.makeKeyAndVisible()
                }
            }
        } else  {
            window?.rootViewController = AuntificationViewController()
             window?.makeKeyAndVisible()
        }
       
    }
}

