//
//  ActiveCell.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 03.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

protocol ConfiguringCell {
    static var reuseId: String { get }
    func configure<T: Hashable>(with value: T)
}

class ActiveChatsCell: UICollectionViewCell, ConfiguringCell {
 
    static var reuseId: String = "ActiveChatsCell"
    let userImage = UIImageView()
    let username = UILabel(text: "JWdjwldw", font: UIFont.getFontlaoSangamMN20())
    let userLastMessage = UILabel(text: "DWDWL", font: UIFont.getFontlaoSangamMN14())
    let isReadView = GradientView(frame: .zero, startPoint: .topTrailing, endPoint: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<T>(with value: T) where T : Hashable {
         guard let userChat = value as? UserChat else { return }
//        if userChat.userImageString
         username.text = userChat.username
         userLastMessage.text = userChat.lastMessage
     }
    
    private func setupConstraint() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        userLastMessage.translatesAutoresizingMaskIntoConstraints = false
        isReadView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(userImage)
        self.addSubview(isReadView)
        self.addSubview(username)
        self.addSubview(userLastMessage)
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: self.topAnchor),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            userImage.widthAnchor.constraint(equalTo: userImage.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            isReadView.topAnchor.constraint(equalTo: self.topAnchor),
            isReadView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            isReadView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            isReadView.widthAnchor.constraint(equalToConstant: 8)
        ])
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            username.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16),
            username.trailingAnchor.constraint(equalTo: isReadView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            userLastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            userLastMessage.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16),
            userLastMessage.trailingAnchor.constraint(equalTo: isReadView.leadingAnchor, constant: 16)
        ])
        
        
        
    }
    
}
