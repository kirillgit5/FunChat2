//
//  UserError.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 12.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

enum UserError: Error {
    case canNotConvertToUSerInformation
    case userDidNotFinishRegistration
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .canNotConvertToUSerInformation:
            return NSLocalizedString("Can not convert to UserInformation", comment: "")
        case .userDidNotFinishRegistration:
            return NSLocalizedString("User did not finish registration", comment: "")
            
        default:
            return nil
        }
    }
}
