//
//  MessagePanel.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 10.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class MessagePanel: UIView {
    private let infoLabel = UILabel(text: "", font: UIFont.getFontAvenir20())
    private let textField = StrartChatTextField()
    
    convenience init (color: UIColor, infoText: String = "Write message") {
        self.init(frame: .zero)
        backgroundColor = color
        layer.cornerRadius = 30
        infoLabel.text = infoText
        infoLabel.textAlignment = .center
        setupLayout()
    }
    
    private func setupLayout() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(infoLabel)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
