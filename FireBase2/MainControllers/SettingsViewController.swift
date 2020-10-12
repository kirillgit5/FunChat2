//
//  SettingsViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 12.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    private let logOutButton = UIButton(title: "Log Out", titleColor: .getRedColorForButton(), backgroundColor: .white, font: UIFont.getFontAvenir26(), isShadow: false, cornerRadius: 15)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .getWhiteColorForMain()
        setupLayout()
        addTargets()
        setupViews()
        
    }
    
    private func setupViews() {
        logOutButton.layer.borderWidth = 1.3
        logOutButton.layer.borderColor = UIColor.getRedColorForButton().cgColor
        navigationItem.title = "Settings"
    }
    
    private func addTargets() {
        logOutButton.addTarget(self, action: #selector(logOut), for: UIControl.Event.touchUpInside)
    }
    
    private func setupLayout() {
        let stackView = UIStackView(subViews: [logOutButton], axis: .vertical, spacing: 20)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logOutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    
    @objc func logOut() {
        let alertController = UIAlertController(title: "Attention", message: "Are you sure you want to exit?", preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { (_) in
            do {
                try Auth.auth().signOut()
                UIApplication.shared.keyWindow?.rootViewController = AuntificationViewController()
            } catch {
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

}
