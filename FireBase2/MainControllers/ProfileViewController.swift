//
//  ProfileViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 09.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let messagePanelView = MessagePanel(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), infoText: "Write message")
    private let userPhotoImageView = AddPhotoImageView(frame: .zero)
    private let nameLabel = UILabel(text: "Name:", font: UIFont.getFontAvenir20())
    private let aboutMeLabel = UILabel(text: "About me: ", font: UIFont.getFontAvenir20())
    private let birthdayLabel = UILabel(text: "Birthday: ", font: UIFont.getFontAvenir20())
    private let placeLabel = UILabel(text: "Place: ", font: UIFont.getFontAvenir20())
    private let colorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsDesigh()
        setupConstraint()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width/2
    }
    
    private func setupViewsDesigh() {
        aboutMeLabel.numberOfLines = 0
        view.backgroundColor = .white
        colorView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
  
    }
    
    private func setupConstraint() {
        let informationStackView = UIStackView(subViews: [nameLabel, aboutMeLabel, birthdayLabel, placeLabel], axis: .vertical, spacing: 5)
        informationStackView.distribution = .fillEqually
        messagePanelView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userPhotoImageView)
        view.addSubview(colorView)
        view.addSubview(messagePanelView)
        view.addSubview(informationStackView)
        
        
        NSLayoutConstraint.activate([
            messagePanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            messagePanelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messagePanelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messagePanelView.heightAnchor.constraint(equalToConstant: view.frame.height/5)
        ])
        
        NSLayoutConstraint.activate([
            colorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.widthAnchor.constraint(equalTo: userPhotoImageView.heightAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: view.frame.width/2)
        ])
        
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 30),
            informationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            informationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            informationStackView.bottomAnchor.constraint(equalTo: messagePanelView.topAnchor, constant: -40)
            
        ])
        
        
    }
    
    
    
}
