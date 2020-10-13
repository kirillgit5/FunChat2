//
//  SetupProfile.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 11.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol SetupProfileViewModelProtocol: class {
    
    init(currentUser: User)
    var alertMessage: Box<String> { get }
    var dateForShow: Box<String> { get }
    func setupUserProfile(with firstName: String?, lastName: String?, aboutMe: String?, place: String?, male: String?, userImage: UIImage?, complition: @escaping ((Bool) -> Void) )
    func getLocale() -> Locale
    func setDate(date: Date)
    func getDate() -> Date
    func getMainTabBarViewModel() -> MainTabBarViewModelProtocol?
}


class SetupProfileViewModel: SetupProfileViewModelProtocol {
    
    
    var alertMessage: Box<String> = Box(value: "")
    
    var dateForShow: Box<String> = Box(value:  DateManager.shared.localizeDate(date: Date()))
    
    private var date = Date()
    private let currentUser: User
    private var user: UserInformation?
    
    private lazy var dataBase: FireStroreService = {
        FireStroreService.shared
    }()
    
    private lazy var storageService: StorageService = {
        StorageService.shared
    }()
    
    required init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    func setupUserProfile(with firstName: String?, lastName: String?, aboutMe: String?, place: String?, male: String?, userImage: UIImage?, complition: @escaping ((Bool) -> Void)) {
        let alertError = ValidatorService.checkProfileData(firstName: firstName, lastName: lastName, male: male)
        
        if alertError.successfully {
            if userImage == #imageLiteral(resourceName: "avatar") {
                dataBase.saveUserProfile(id: currentUser.uid, email: currentUser.email!,
                                         firstName: firstName!, lastName: lastName!,
                                         description: aboutMe ?? "", birthday: date,
                                         sex: male!, place: place ?? "",
                                         userImageString: "default") {[unowned self] (result) in
                                            switch result {
                                            case .success(let user):
                                                self.user = user
                                                complition(true)
                                            case .failure(let error):
                                                complition(false)
                                                self.alertMessage.value = error.localizedDescription
                                            }
                }
            } else {
                storageService.loadUserPhoto(userPhoto: userImage!, userId: currentUser.uid) {[unowned self] (result) in
                    switch result {
                    case .success(let url):
                        let stringURL = url.absoluteString
                        self.dataBase.saveUserProfile(id: self.currentUser.uid, email: self.currentUser.email!,
                                                      firstName: firstName!, lastName: lastName!,
                                                      description: aboutMe ?? "", birthday: self.date,
                                                      sex: male!, place: place ?? "",
                                                      userImageString: stringURL) {[unowned self] (result) in
                                                        switch result {
                                                        case .success(let user):
                                                            self.user = user
                                                            complition(true)
                                                        case .failure(let error):
                                                            complition(false)
                                                            self.alertMessage.value = error.localizedDescription
                                                        }
                        }
                    case .failure(let error):
                        complition(false)
                        self.alertMessage.value = error.localizedDescription
                    }
                }
            }
        } else {
            alertMessage.value = alertError.message
            complition(false)
        }
        
    }
    
    func getLocale() -> Locale {
        guard let langStr = Locale.current.languageCode else { return Locale(identifier: "ru_RU")}
        let locale = Locale(identifier: langStr)
        return locale
    }
    
    func setDate(date: Date) {
        self.date = date
        dateForShow.value = DateManager.shared.localizeDate(date: date)
    }
    
    func getDate() -> Date {
        date
    }
    
    func getMainTabBarViewModel() -> MainTabBarViewModelProtocol? {
        guard let userInformation = user else { return nil}
        return MainTabBarViewModel(user: userInformation)
    }
}
