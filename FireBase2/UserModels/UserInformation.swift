//
//  UserInformation.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 03.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct UserInformation: Hashable, Decodable {
    var username: String {
        "\(firstName)  \(lastName)"
    }
    var firstName: String
    var lastName: String
    var avatarStringURL: String
    var id: String
    var birthday: Date
    var description: String
    var email: String
    var place: String
    var sex: String
    
    init(firstName: String , lastName: String, avatarStringURL: String, id: String, birthday: Date, description: String, email: String, place: String, sex: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.avatarStringURL = avatarStringURL
        self.birthday = birthday
        self.description = description
        self.id = id
        self.place = place
        self.sex = sex
        self.email = email
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let firstName = data["firstName"] as? String else { return nil }
        guard let lastName = data["lastName"] as? String else { return nil }
        guard let avatarStringURL = data["avatarStringURL"] as? String else { return nil }
        guard let birthdayTimestamp = data["birthday"] as? Timestamp else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let place = data["place"] as? String else { return nil }
        guard let sex = data["sex"] as? String else { return nil }
        guard let email = data["email"] as? String else { return nil }
        guard let id = data["uid"] as? String else { return nil }
        
        let birthday = birthdayTimestamp.dateValue()
        self.firstName = firstName
        self.lastName = lastName
        self.avatarStringURL = avatarStringURL
        self.birthday = birthday
        self.description = description
        self.id = id
        self.place = place
        self.sex = sex
        self.email = email
        
    }
    
    var dictionaryForSave: [String : Any] {
        var dictionary: [String: Any] = [:]
        dictionary["firstName"] = firstName
        dictionary["lastName"] = lastName
        dictionary["avatarStringURL"] = avatarStringURL
        dictionary["uid"] = id
        dictionary["description"] = description
        dictionary["email"] = email
        dictionary["place"] = place
        dictionary["sex"] = sex
        dictionary["birthday"] = Timestamp(date: birthday)
        return dictionary
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UserInformation, rhs: UserInformation) -> Bool {
        lhs.id == rhs.id
    }
    
    func containsSubLine(subLine: String) -> Bool {
        if subLine.isEmpty { return true }
        let lowerCaseLine = subLine.lowercased()
        return username.lowercased().contains(lowerCaseLine)
    }
}
