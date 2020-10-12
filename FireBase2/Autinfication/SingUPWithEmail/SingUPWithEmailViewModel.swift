//
//  SingUPWithEmailViewModel.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 10.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol SingUPWithEmailViewModelProtocol {
    var alertMessage: Box<String> { get }
    func singUP(with login: String?, password: String?, confirmPassword: String?, complition: @escaping ((Bool) -> Void))
    func getSetupProfileViewModel() -> SetupProfileViewModelProtocol?
}

class SingUPWithEmailViewModel: SingUPWithEmailViewModelProtocol {
    
    
    var alertMessage: Box<String> = Box(value: "")
    
    private lazy var auntService = AuthService.shared
   
    
    func singUP(with login: String?, password: String?, confirmPassword: String?, complition: @escaping ((Bool) -> Void)) {
        let alertError = ValidatorService.checkSingUPData(login: login, password: password, confirmPassword: confirmPassword)
        
        if alertError.successfully {
    
            self.auntService.registerUser(email: login!, password: password!) {[unowned self] (result) in
                switch result {
                case .success( let user):
                    complition(true)
                    
                case .failure(let error):
                    complition(false)
                    self.alertMessage.value = error.localizedDescription
                }
            }
        } else {
            self.alertMessage.value = alertError.message
            complition(false)
            
        }
    }
    
    func getSetupProfileViewModel() -> SetupProfileViewModelProtocol? {
        guard let user = Auth.auth().currentUser else { return nil }
        return SetupProfileViewModel(currentUser: user)
    }
    
    
}
