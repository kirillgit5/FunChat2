//
//  LoginViewModel.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 11.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit


//protocol LoginViewModelProtocol {
//    var alertMessage: Box<String> { get }
//    func login(with email: String?, password: String?, complition: @escaping ((Bool) -> Void))
//}
//
//class LoginViewModel: LoginViewModelProtocol {
//   
//    var alertMessage: Box<String> = Box(value: "")
//    
//    private lazy var auntService = AuthService.shared
//    private lazy var firebaseService = FireStroreService.shared
//    
//    
//    func login(with email: String?, password: String?, complition: @escaping ((Bool) -> Void)) {
//        let alertError = ValidatorService.checkLoginData(login: email, password: password)
//        if alertError.successfully {
//            self.auntService.login(email: email!, password: password!) {[unowned self] (result) in
//                switch result {
//                    
//                case .success(let user):
//                    self.firebaseService.getUserInformation(user: user) { (result) in
//                        switch result {
//                        case .success(let user):
//                            
//                        case .failure(_):
//                            let setupUserProfileViewModel = SetupProfileViewModel(currentUser: user)
//                            let setupProfileVC = SetupProfileViewController()
//                            setupProfileVC.viewModel = setupUserProfileViewModel
//                            UIApplication.shared.keyWindow?.rootViewController = setupProfileVC
//                        }
//                    }
//                    complition(true)
//                    
//                case .failure(let error):
//                    complition(false)
//                    self.alertMessage.value = error.localizedDescription
//                }
//            }
//        } else {
//            self.alertMessage.value = alertError.message
//            complition(false)
//            
//        }
//    }
//}

