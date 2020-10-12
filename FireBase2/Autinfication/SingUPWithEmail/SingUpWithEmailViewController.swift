//
//  SingUpWithEmailViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 25.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class SingUpWithEmailViewController: UIViewController {
    //MARK: - Private Property
    
    
    weak  var navigationDelegate: AuthNavigationDelegate?
    //MARK: - Labels
    private let greetingLabel = UILabel(text: "Create your account", font: .getFontAvenir26())
    private let emailLabel = UILabel(text: "Email")
    private let passwordLabel = UILabel(text: "Password")
    private let confirmPasswordLabel = UILabel(text: "Confirm password")
    private let alreadySingUpLabel = UILabel(text: "Already sing up ?")
    private let alertLabel = UILabel(text: "", font: UIFont.getFontAvenir14())
    
    //MARK: - Buttons
    private let singUpButton = UIButton(title: "Sing up", titleColor: .white, backgroundColor: .getBlackColor())
    private let loginButton = UIButton(title: "Login", titleColor: .getRedColorForButton(), backgroundColor: .white)
    
    //MARK: - TextFields
    private let emailTextField = OneLineTextField(font: .getFontAvenir18())
    private let passwordTextField = OneLineTextField(font: .getFontAvenir18())
    private let confirmPasswordTextField = OneLineTextField(font: .getFontAvenir18())
    private let viewModel: SingUPWithEmailViewModelProtocol = SingUPWithEmailViewModel()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    
    private lazy var loginStackView: UIStackView = {
        UIStackView(subViews: [alreadySingUpLabel, loginButton], axis: .horizontal, spacing: 10)
    }()
    
    private var heightlLoginStackView: CGFloat {
        loginStackView.frame.origin.y + loginStackView.frame.size.height
    }
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrainst()
        addTargetToButtons()
        designViews()
        viewModel.alertMessage.bind {[unowned self] (error) in
            self.alertLabel.text = error
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidDisappear), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        emailTextField.text = nil
        passwordTextField.text = nil
        confirmPasswordTextField.text = nil
        super.viewDidDisappear(true)
    }
    
    
    //MARK: - Private Methods
    private func designViews() {
        view.backgroundColor = .white
        alertLabel.textColor = .getRedColorForButton()
        loginButton.contentHorizontalAlignment = .leading
        
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        confirmPasswordTextField.autocorrectionType = .no
        
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        confirmPasswordTextField.autocapitalizationType = .none
        
        emailTextField.tag = 0
        passwordTextField.tag = 1
        confirmPasswordTextField.tag = 2
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
    }
    
    private func addTargetToButtons() {
        singUpButton.addTarget(self, action: #selector(singUP), for: UIControl.Event.touchUpInside)
        loginButton.addTarget(self, action: #selector(logIn), for: UIControl.Event.touchUpInside)
    }
    
    private func setupConstrainst() {
        let emailStackView = UIStackView(subViews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(subViews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        let confirmPasswordStackView = UIStackView(subViews: [confirmPasswordLabel, confirmPasswordTextField], axis: .vertical, spacing: 0)
        
        
        
        let signupStackView = UIStackView(subViews: [emailStackView, passwordStackView, confirmPasswordStackView, singUpButton],
                                          axis: .vertical,
                                          spacing: 40)
        
        
        loginStackView.alignment = .firstBaseline
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        signupStackView.translatesAutoresizingMaskIntoConstraints = false
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        singUpButton.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(greetingLabel)
        scrollView.addSubview(signupStackView)
        scrollView.addSubview(loginStackView)
        scrollView.addSubview(alertLabel)
        
        
        
        singUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 40),
            greetingLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alertLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 40),
            alertLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signupStackView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 100),
            signupStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signupStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            loginStackView.topAnchor.constraint(equalTo: signupStackView.bottomAnchor, constant: 60),
            loginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    //MARK: - Selectors
    @objc func singUP() {
        viewModel.singUP(with: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text) {[unowned self] (successfully) in
            if successfully, let userProfileVM = self.viewModel.getSetupProfileViewModel() {
                let setupProfileVC = SetupProfileViewController(viewModel: userProfileVM)
                setupProfileVC.modalPresentationStyle = .fullScreen
                self.present(setupProfileVC, animated: true, completion: nil)
            } else {
                self.passwordTextField.shakeAnimation()
                self.confirmPasswordTextField.shakeAnimation()
                self.passwordTextField.text = nil
                self.confirmPasswordTextField.text = nil
            }
        }
    }
    
    @objc func logIn() {
        dismiss(animated: true) {[unowned self] in
            self.navigationDelegate?.presentLoginVC()
        }
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let del = view.frame.height - keyboardFrameSize.height
        if heightlLoginStackView > del + 20 {
            scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height + heightlLoginStackView - del + 40)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height + view.bounds.size.height + heightlLoginStackView - del + 40, right: 0)
        }
    }
    
    @objc func keyboardDidDisappear() {
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    
}

extension SingUpWithEmailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return true }
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        switch textField.tag {
        case 0:
            return updatedText.count < 30
        case 1:
            return updatedText.count < 50
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passwordTextField.becomeFirstResponder()
        case 1:
            confirmPasswordTextField.becomeFirstResponder()
        case 2:
            confirmPasswordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension SingUpWithEmailViewController: UIScrollViewDelegate {
    
}

//MARK: - SwiftUI
import SwiftUI
struct SingUpWithEmailViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentation().edgesIgnoringSafeArea(.all)
    }
    
    struct ViewControllerRepresentation: UIViewControllerRepresentable {
        let viewController = SingUpWithEmailViewController()
        
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
    }
}
