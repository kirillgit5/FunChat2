//
//  LoginViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 25.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    weak var navigationDelegate: AuthNavigationDelegate?
    //MARK: - Private property
    private lazy var auntService = AuthService.shared
    private lazy var firebaseService = FireStroreService.shared
    //MARK: - Labels
    private let greetingLabel = UILabel(text: "Login in your account", font: .getFontAvenir26())
    private let signUpLabel = UILabel(text: "Need an account?")
    private let emailLabel = UILabel(text: "Email")
    private let alertLabel = UILabel(text: "", font: .getFontAvenir14())
    private let passwordLabel = UILabel(text: "Password")
    
    //MARK: - TextFields
    private let emailTextField = OneLineTextField(font: .getFontAvenir18())
    private let passwordTextField = OneLineTextField(font: .getFontAvenir18())
    
    //MARK: - Buttons
    private let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .getBlackColor())
    private let signUpButton = UIButton(title: "Sign up", titleColor: .getRedColorForButton(), backgroundColor: .white)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designViews()
        addTargetToButtons()
        setupConstrainst()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - Private Methods
    private func designViews() {
        view.backgroundColor = .white
        alertLabel.textColor = .getRedColorForButton()
        alertLabel.textAlignment = .center
        alertLabel.numberOfLines = 0
        
        passwordTextField.isSecureTextEntry = true
        
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        
    }
    
    private func addTargetToButtons() {
        loginButton.addTarget(self, action: #selector(login), for: UIControl.Event.touchUpInside)
        signUpButton.addTarget(self, action: #selector(singUP), for: UIControl.Event.touchUpInside)
    }
    
    private func setupConstrainst() {
        view.translatesAutoresizingMaskIntoConstraints = false
        let emailStackView = UIStackView(subViews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(subViews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        let logInStackView = UIStackView(subViews: [emailStackView, passwordStackView, loginButton], axis: .vertical, spacing: 40)
        
        signUpButton.contentHorizontalAlignment = .leading
        let signUpStackView = UIStackView(subViews: [signUpLabel, signUpButton], axis: .horizontal, spacing: 10)
        signUpStackView.alignment = .firstBaseline
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        logInStackView.translatesAutoresizingMaskIntoConstraints = false
        signUpStackView.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logInStackView)
        view.addSubview(signUpStackView)
        view.addSubview(greetingLabel)
        view.addSubview(alertLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alertLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 40),
            alertLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            logInStackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 70),
            logInStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logInStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            signUpStackView.topAnchor.constraint(equalTo: logInStackView.bottomAnchor, constant: 20),
            signUpStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc func login() {
        let alertError = ValidatorService.checkLoginData(login: emailTextField.text, password: passwordTextField.text)
        if alertError.successfully {
            self.auntService.login(email: emailTextField.text!, password: passwordTextField.text!) {[unowned self] (result) in
                switch result {
                    
                case .success(let user):
                    self.firebaseService.getUserInformation(user: user) {[unowned self] (result) in
                        switch result {
                        case .success(let user):
                            let viewModel = MainTabBarViewModel(user: user)
                            let mainTabBarVC = MainTabBarController(viewModel: viewModel)
                            mainTabBarVC.modalPresentationStyle = .fullScreen
                            self.present(mainTabBarVC, animated: true)
                            
                        case .failure(_):
                            let setupUserProfileViewModel = SetupProfileViewModel(currentUser: user)
                            let setupProfileVC = SetupProfileViewController(viewModel: setupUserProfileViewModel)
                            setupProfileVC.modalPresentationStyle = .fullScreen
                            self.present(setupProfileVC, animated: true)
                        }
                    }
                    
                case .failure(let error):
                    self.alertLabel.text = error.localizedDescription
                    self.passwordTextField.shakeAnimation()
                    self.passwordTextField.text = nil
                }
            }
        } else {
            self.passwordTextField.shakeAnimation()
            self.passwordTextField.text = nil
            self.alertLabel.text = alertError.message
        }
    }
    
    @objc func singUP() {
        
        dismiss(animated: true) {[unowned self] in
            self.navigationDelegate?.presentSingUPVC()
        }
    }
    
}
