//
//  UserCell.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 03.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell, ConfiguringCell {
 
    static let reuseId: String = "UserCell"
    
    private let userImageView = UIImageView()
    private let usernameLabel = UILabel(text: "", font:  .getFontlaoSangamMN14())
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .white
        self.layer.cornerRadius = 4
        
        self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        usernameLabel.textAlignment = .center
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 4
        self.containerView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<T>(with value: T) where T : Hashable {
         guard let userInformation = value as? UserInformation else { return }
         usernameLabel.text = userInformation.username
        if userInformation.avatarStringURL == "default" {
            userImageView.image = UIImage(named: "avatar")
        } else {
            userImageView.fetchImage(from: userInformation.avatarStringURL)
        }
     }

    
    private func setupLayout() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        containerView.addSubview(userImageView)
        containerView.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            usernameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            usernameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
}
