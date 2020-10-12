//
//  ValidatorService.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 11.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct AlertError {
    var successfully: Bool
    var message = ""
}

class ValidatorService {
    
    static func checkSingUPData(login: String?, password: String?, confirmPassword: String?) -> AlertError {
        guard let _ = login else { return AlertError(successfully: false, message: "Write your email") }
        guard let password = password else { return AlertError(successfully: false, message: "Write password") }
        guard let confirmPassword = confirmPassword else { return AlertError(successfully: false, message: "Write password") }
        guard  confirmPassword.count >= 8 && password.count >= 8 else { return AlertError(successfully: false, message: "Password must contains 8 characters or more")}
        guard confirmPassword == password else { return AlertError(successfully: false, message: "Passwords must be qual") }
        return AlertError(successfully: true)
    }
    
    static func checkLoginData(login: String?, password: String?) -> AlertError {
        guard let _ = login else { return AlertError(successfully: false, message: "Write your email") }
        guard let _ = password else { return AlertError(successfully: false, message: "Write password") }
        return AlertError(successfully: true)
    }
    
    static func checkProfileData(firstName: String?, lastName: String?, male: String?) -> AlertError {
        guard let firstName  = firstName, firstName.count > 2 else { return AlertError(successfully: false, message: "Write your firstName") }
        guard let lastName = lastName, lastName.count > 2 else { return AlertError(successfully: false, message: "Write your lastName") }
        guard let _ = male else { return AlertError(successfully: false, message: "Choose your male") }
        return AlertError(successfully: true)
    }
}
