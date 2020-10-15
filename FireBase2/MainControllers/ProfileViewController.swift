//
//  ProfileViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 09.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private let user: UserInformation
    private let currentUser: UserInformation
    
    private let messagePanelView = MessagePanel(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), infoText: "Write message")
    private let userPhotoImageView = AddPhotoImageView(frame: .zero)
    private let nameLabel = UILabel(text: "Name: ", font: UIFont.getFontAvenir20())
    private let aboutMeLabel = UILabel(text: "About me: ", font: UIFont.getFontAvenir20())
    private let birthdayLabel = UILabel(text: "Birthday: ", font: UIFont.getFontAvenir20())
    private let placeLabel = UILabel(text: "Place: ", font: UIFont.getFontAvenir20())
    private let colorView = UIView()
    private let startMessageButton = UIButton(title: "Write message", titleColor: .white, backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), cornerRadius: 20)
    
    init(user: UserInformation, currentUser: UserInformation) {
        self.user = user
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsDesigh()
        setupConstraint()
        startMessageButton.addTarget(self, action: #selector(writeMessage), for: UIControl.Event.touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width/2
        super.viewDidLayoutSubviews()
    }
    
    private func setupViewsDesigh() {
        aboutMeLabel.numberOfLines = 0
        view.backgroundColor = .white
        colorView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        userPhotoImageView.fetchImage(from: user.avatarStringURL)
        nameLabel.text! += user.username
        aboutMeLabel.text! += user.description
        birthdayLabel.text! += DateManager.shared.localizeDate(date: user.birthday)
        placeLabel.text! += user.place
    }
    
    private func setupConstraint() {
        let informationStackView = UIStackView(subViews: [nameLabel, aboutMeLabel, birthdayLabel, placeLabel], axis: .vertical, spacing: 5)
        
        startMessageButton.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.distribution = .fillEqually
        messagePanelView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        //        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(startMessageButton)
        view.addSubview(userPhotoImageView)
        //        view.addSubview(colorView)
        //        view.addSubview(messagePanelView)
        view.addSubview(informationStackView)
        
        
        //        NSLayoutConstraint.activate([
        //            messagePanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        //            messagePanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            messagePanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //            messagePanelView.heightAnchor.constraint(equalToConstant: view.frame.height/5)
        //        ])
        
        //        NSLayoutConstraint.activate([
        //            colorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        //            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //            colorView.heightAnchor.constraint(equalToConstant: 40)
        //        ])
        
        NSLayoutConstraint.activate([
            startMessageButton.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 30),
            startMessageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            startMessageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            startMessageButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.widthAnchor.constraint(equalTo: userPhotoImageView.heightAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: view.frame.width/2)
        ])
        
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: startMessageButton.bottomAnchor, constant: 30),
            informationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            informationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            informationStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -view.frame.height/5)
            
        ])
        
    }
    
    @objc func writeMessage() {
        let chatVC = ChatViewControlelr(senderhUser: currentUser, receiverUser: user)
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
    
}
