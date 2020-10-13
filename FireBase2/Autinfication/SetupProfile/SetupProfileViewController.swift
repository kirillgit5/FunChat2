//
//  SetupProfileViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 25.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    //MARK: - Private Property
    private let viewModel: SetupProfileViewModelProtocol
    private lazy var scrollView: AuthScrollView = {
        let scrollView = AuthScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        //        scrollView.delegate = self
        
        return scrollView
    }()
    
    private var addPhotoImageView = AddPhotoImageView(frame: .zero)
    
    private var addPhotoButton = AddPhotoButton(frame: .zero)
    
    private let firstNameLabel = UILabel(text: "First name")
    private let lastNameLabel = UILabel(text: "Last name")
    private let infoLabel = UILabel(text: "Set up your profile", font: .getFontAvenir26())
    private let birthdayLabel = UILabel(text: "Birthday")
    private let placeLabel = UILabel(text: "Place")
    private let aboutMeLabel = UILabel(text: "About me")
    private let sexLabel = UILabel(text: "Sex")
    private let birthdayButton = UIButton(title: "", titleColor: .white, backgroundColor: .systemGray)
    
    private let firstNameTextField = OneLineTextField(font: .getFontAvenir18())
    private let lastNameTextField = OneLineTextField(font: .getFontAvenir18())
    private let aboutMeNameTextField = OneLineTextField(font: .getFontAvenir18())
    private let placeNameTextField = OneLineTextField(font: .getFontAvenir18())
    
    private let loginButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .getBlackColor())
    private let alertLabel = UILabel(text: "", font: .getFontAvenir14())
    
    
    private lazy var birthdayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let sexSegmentControl = UISegmentedControl(first: "Male", second: "Female")
    
    //MARK: - Init
    
    init(viewModel: SetupProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        addTarget()
        setupViews()
        viewModel.dateForShow.bind {[unowned self] (date) in
            self.birthdayButton.setTitle(date, for: .normal)
        }
        
        viewModel.alertMessage.bind { (error) in
            self.alertLabel.text = error
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addPhotoImageView.layer.cornerRadius = addPhotoImageView.frame.width/2
    }
    
    
    //MARK: - Private Methods
    private func addTarget() {
        loginButton.addTarget(self, action: #selector(login), for: UIControl.Event.touchUpInside)
        birthdayButton.addTarget(self, action: #selector(setData), for: UIControl.Event.touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(addUserPhoto), for: UIControl.Event.touchUpInside)
        
    }
    
    private func setupViews() {
        alertLabel.textColor = .getRedColorForButton()
        alertLabel.textAlignment = .center
        alertLabel.numberOfLines = 0
        
        firstNameTextField.autocorrectionType = .no
        lastNameTextField.autocorrectionType = .no
        aboutMeNameTextField.autocorrectionType = .no
        placeNameTextField.autocorrectionType = .no
        
        firstNameTextField.autocapitalizationType = .none
        lastNameTextField.autocapitalizationType = .none
        aboutMeNameTextField.autocapitalizationType = .none
        placeNameTextField.autocapitalizationType = .none
        
        firstNameTextField.tag = 0
        lastNameTextField.tag = 1
        placeNameTextField.tag = 2
        aboutMeNameTextField.tag = 3
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        placeNameTextField.delegate = self
        aboutMeNameTextField.delegate = self
        
        sexSegmentControl.selectedSegmentIndex = 0
    }
    
    
    private func setupConstraints() {
        super.viewDidLayoutSubviews()
        let spacerView = UIView()
        let firstNameStackView = UIStackView(subViews: [firstNameLabel, firstNameTextField], axis: .vertical, spacing: 0)
        let lastNameNameStackView = UIStackView(subViews: [lastNameLabel, lastNameTextField], axis: .vertical, spacing: 0)
        let placeStackView = UIStackView(subViews: [placeLabel, placeNameTextField], axis: .vertical, spacing: 0)
        let aboutMeStackView = UIStackView(subViews: [aboutMeLabel, aboutMeNameTextField], axis: .vertical, spacing: 0)
        let ageStackView = UIStackView(subViews: [birthdayLabel, birthdayButton], axis: .vertical, spacing: 0)
        let sexStackView = UIStackView(subViews: [sexLabel, sexSegmentControl], axis: .vertical, spacing: 0)
        
        let logInStackView = UIStackView(subViews: [firstNameStackView, lastNameNameStackView, placeStackView, aboutMeStackView, ageStackView,sexStackView ,loginButton,spacerView], axis: .vertical, spacing: 40)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        logInStackView.translatesAutoresizingMaskIntoConstraints = false
        addPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(infoLabel)
        scrollView.addSubview(alertLabel)
        scrollView.addSubview(logInStackView)
        scrollView.addSubview(addPhotoButton)
        scrollView.addSubview(addPhotoImageView)
        
        
        spacerView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            infoLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoImageView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            addPhotoImageView.centerXAnchor.constraint(equalTo: infoLabel.centerXAnchor),
            addPhotoImageView.widthAnchor.constraint(equalTo: addPhotoImageView.heightAnchor),
            addPhotoImageView.heightAnchor.constraint(equalToConstant: view.frame.width/3)
        ])
        
        NSLayoutConstraint.activate([
            addPhotoButton.leadingAnchor.constraint(equalTo: addPhotoImageView.trailingAnchor, constant: 20),
            addPhotoButton.centerYAnchor.constraint(equalTo: addPhotoImageView.centerYAnchor),
            addPhotoButton.heightAnchor.constraint(equalTo: addPhotoButton.widthAnchor),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            alertLabel.topAnchor.constraint(equalTo: addPhotoImageView.bottomAnchor, constant: 20),
            alertLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        
        
        NSLayoutConstraint.activate([
            logInStackView.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 10),
            logInStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logInStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            logInStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        
    }
    
    @objc func login() {
        print()
        viewModel.setupUserProfile(with: firstNameTextField.text, lastName: lastNameTextField.text,
                                   aboutMe: aboutMeNameTextField.text, place: placeNameTextField.text,
                                   male: sexSegmentControl.titleForSegment(at: sexSegmentControl.selectedSegmentIndex), userImage: addPhotoImageView.image) {[unowned self] (successfully) in
                                    if successfully, let viewModel =  self.viewModel.getMainTabBarViewModel() {
                                        let mainTabBarController = MainTabBarController(viewModel: viewModel)
                                        mainTabBarController.modalPresentationStyle = .fullScreen
                                        self.present(mainTabBarController, animated: true)
                                    } else {
                                        self.viewModel.alertMessage.value = "Registration error"
                                    }
        }
        
    }
    
    @objc func setData() {
        let alert = UIAlertController(style: .actionSheet, source: view)
        
        alert.addDatePicker(date: viewModel.getDate(), locale: viewModel.getLocale()) { [unowned self] date in
            self.viewModel.setDate(date: date)
        }
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        alert.show(animated: true, vibrate: false, viewController: self)
    }
    
    @objc func addUserPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    
}

//MARK: - UIScrollViewDelegate
extension SetupProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        if(scrollView.contentOffset.x != 0){
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y), animated: true)
        }
    }
}

//MARK: - UITextFieldDelegate
extension SetupProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return true }
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        switch textField.tag {
        case 0:
            return updatedText.count < 12
        case 1:
            return updatedText.count < 12
        case 2:
            return updatedText.count < 20
        case 3:
            return updatedText.count < 30
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            lastNameTextField.becomeFirstResponder()
        case 1:
            placeNameTextField.becomeFirstResponder()
        case 2:
            aboutMeNameTextField.becomeFirstResponder()
        case 3:
            aboutMeNameTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        addPhotoImageView.image = image
    }
}
