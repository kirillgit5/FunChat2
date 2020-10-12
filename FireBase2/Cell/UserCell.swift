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
    private let usernameLabel = UILabel(text: "", font:  .getFontlaoSangamMN20())
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        containerView.layer.cornerRadius = 6
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        usernameLabel.textAlignment = .center
        self.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<T>(with value: T) where T : Hashable {
         guard let userInformation = value as? UserInformation else { return }
         usernameLabel.text = userInformation.username
         userImageView.image = UIImage(named: "avatar")
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
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            userImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
}
