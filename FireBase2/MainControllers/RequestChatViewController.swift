//
//  RequestChatViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 10.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class RequestChatViewControoler: UIViewController {
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "UsersTabBar"), contentMode: .scaleAspectFill)
    private let chatRequestView = AcceptMessagePanel(color: .getWhiteColorForMain())
    private let colorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        colorView.backgroundColor = .getWhiteColorForMain()
        chatRequestView.delegate = self
        
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        chatRequestView.translatesAutoresizingMaskIntoConstraints = false
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(colorView)
        view.addSubview(chatRequestView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: chatRequestView.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            chatRequestView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            chatRequestView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatRequestView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatRequestView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            colorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension RequestChatViewControoler: AcceptChatViewDelegate {
    func acceptChat() {
        print("accept")
    }
    
    func cancelChat() {
        print("cancel")
    }
    
    
}
