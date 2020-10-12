//
//  AcceptMessagePanel.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 10.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

protocol AcceptChatViewDelegate: class {
    func acceptChat()
    func cancelChat()
}


class AcceptMessagePanel: UIView {
    
    //MARK: - Private Property
    private let acceptButton = UIButton(title: "Accept", titleColor: .systemGreen, backgroundColor: .getWhiteColorForMain(), font: UIFont.getFontAvenir26(), isShadow: false, cornerRadius: 15)
    private let cancelButton = UIButton(title: "Cancel", titleColor: .getRedColorForButton(), backgroundColor: .getWhiteColorForMain(), font: UIFont.getFontAvenir26(), isShadow: false, cornerRadius: 15)
    private let nameLabel = UILabel(text: "Kirill Kramar", font: UIFont.getFontAvenir20())
    private let aboutMeLabel = UILabel(text: "I am conch", font: UIFont.getFontAvenir18())
    
    //MARK: - Public Property
    weak var delegate: AcceptChatViewDelegate?

    convenience init (color: UIColor) {
        self.init(frame: .zero)
        backgroundColor = color
        layer.cornerRadius = 30
        setupLayout()
        setupViewsDesign()
        acceptButton.addTarget(self, action: #selector(acceptChat), for: UIControl.Event.touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelChat), for: UIControl.Event.touchUpInside)
    }
    
    private func setupViewsDesign() {
        cancelButton.layer.borderWidth = 1.3
        cancelButton.layer.borderColor = UIColor.getRedColorForButton().cgColor
        
        acceptButton.layer.borderWidth = 1.3
        acceptButton.layer.borderColor = UIColor.systemGreen.cgColor
        
    }
    
    
    private func setupLayout() {
        let actionButtonStackView = UIStackView(subViews: [acceptButton, cancelButton], axis: .horizontal, spacing: 18)
        actionButtonStackView.distribution = .fillEqually
        actionButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(actionButtonStackView)
        addSubview(nameLabel)
        addSubview(aboutMeLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            aboutMeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            aboutMeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            actionButtonStackView.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 18),
            actionButtonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            actionButtonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            actionButtonStackView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    @objc func acceptChat() {
        delegate?.acceptChat()
    }
    
    @objc func cancelChat() {
        delegate?.cancelChat()
    }
}
