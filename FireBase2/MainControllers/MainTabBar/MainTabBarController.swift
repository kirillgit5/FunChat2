//
//  MainTabBarController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 02.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let viewModel: MainTabBarViewModelProtocol
    

    init(viewModel: MainTabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let chatVC = MessengerViewController()
        let usersVC = UsersViewController(viewModel: viewModel.getUsersViewModel())
        let settingsVC = SettingsViewController()
        
        let chatTabBarImage = UIImage(systemName: "bubble.left.and.bubble.right.fill")
        let usersTabBarImage = UIImage(systemName: "person.3.fill")
        let settingTabBarImage = UIImage(systemName: "gear")
        
        let usersNC = createNavigationVC(rootViewController: usersVC, title: "Users", image: usersTabBarImage!)
        let chatNC = createNavigationVC(rootViewController: chatVC, title: "Chats", image: chatTabBarImage!)
        let settingsNC = createNavigationVC(rootViewController: settingsVC, title: "Settings", image: settingTabBarImage!)
        
        
        viewControllers = [usersNC, chatNC, settingsNC]
        tabBar.tintColor = #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1)
    }
    
    private func createNavigationVC(rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
}
