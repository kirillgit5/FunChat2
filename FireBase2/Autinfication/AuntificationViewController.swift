//
//  ViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 20.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import GoogleSignIn

protocol AuthNavigationDelegate: class {
    func presentLoginVC()
    func presentSingUPVC()
}

class AuntificationViewController: UIViewController {
    
    //MARK: - Views
    
    private let logoImageView = UILabel(text: "FunChat", font: UIFont.getFontAvenir26())
    
    private let googleLabel = UILabel(text: "Sign up with")
    private let onboardeLabel = UILabel(text: "Already onboard?")
    
    private let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .getBlackColor())
    private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    private let loginButon = UIButton(title: "Login", titleColor: .getRedColorForButton(), backgroundColor: .white, isShadow: true)
    private lazy var loginVC = LoginViewController()
    private lazy var singUPWithEmailVC = SingUpWithEmailViewController()
    private lazy var auntificationService = AuthService.shared
    private lazy var firebaseService = FireStroreService.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        googleButton.customizeGoogleButton()
        setupConstrains()
        addTargetToButtons()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    //MARK: - Private Methods
    private func setupConstrains() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let googleView = AuntificationButtonFormView(label: googleLabel, buttons: googleButton, emailButton)
        let loginView = AuntificationButtonFormView(label: onboardeLabel, buttons: loginButon)
        let stackView = UIStackView(subViews: [googleView, loginView], axis: .vertical, spacing: 40)
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func addTargetToButtons() {
        emailButton.addTarget(self, action: #selector(loginWithEmail), for: UIControl.Event.touchUpInside)
        loginButon.addTarget(self, action: #selector(login), for: UIControl.Event.touchUpInside)
        googleButton.addTarget(self, action: #selector(loginWithGoogle), for: UIControl.Event.touchUpInside)
    }
    
    //MARK: - Selectors
    @objc func loginWithEmail() {
        singUPWithEmailVC.navigationDelegate = self
        present(singUPWithEmailVC, animated: true, completion: nil)
    }
    
    @objc func login() {
        loginVC.navigationDelegate = self
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func loginWithGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
}

extension AuntificationViewController: AuthNavigationDelegate {
    func presentLoginVC() {
        loginVC.navigationDelegate = self
        present(loginVC, animated: true, completion: nil)
    }
    
    func presentSingUPVC() {
         singUPWithEmailVC.navigationDelegate = self
        present(singUPWithEmailVC, animated: true, completion: nil)
    }
}

extension AuntificationViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        auntificationService.loginWithGoogle(user: user, error: error) {[unowned self] (result) in
            switch result {
            case .success(let user):
                self.firebaseService.getUserInformation(user: user) { (result) in
                    switch result {
                        
                    case .success(let userInformation):
                        let viewModel = MainTabBarViewModel(user: userInformation)
                        let mainTabBarVC = MainTabBarController(viewModel: viewModel)
                        mainTabBarVC.modalPresentationStyle = .fullScreen
                        self.present(mainTabBarVC, animated: true)
                    case .failure(_ :):
                        let viewModel = SetupProfileViewModel(currentUser: user)
                        let setupProfileVC = SetupProfileViewController(viewModel: viewModel)
                        setupProfileVC.modalPresentationStyle = .fullScreen
                        self.present(setupProfileVC, animated: true)
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    
}

//MARK: - SwiftUI
import SwiftUI
struct AuntificationViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentation().edgesIgnoringSafeArea(.all)
    }
    
    struct ViewControllerRepresentation: UIViewControllerRepresentable {
        let viewController = AuntificationViewController()
        
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
    }
    
}
