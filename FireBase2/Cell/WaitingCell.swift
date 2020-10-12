//
//  WaitingCell.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 03.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class WaitingCell: UICollectionViewCell, ConfiguringCell {
   
    
    
    static let reuseId: String = "WaitingCell"
    
    private  let userImageView = UIImageView()
    private let usernameLabel = UILabel(text: "", font:  UIFont.getFontlaoSangamMN12())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        usernameLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<T>(with value: T) where T : Hashable {
           guard let userChat = value as? UserChat else { return }
           usernameLabel.text = userChat.username
           userImageView.image = UIImage(named: userChat.userImageString)
       }
    
    private func setupLayout() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(userImageView)
        self.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: self.topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 4),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
}
