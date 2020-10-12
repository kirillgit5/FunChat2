//
//  AuntificationButtonFormView.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 25.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class AuntificationButtonFormView: UIView {
    init(label: UILabel, buttons: UIButton...) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        buttons.forEach {[unowned self] (button) in
            self.addSubview(button)
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        if !buttons.isEmpty {
            buttons.forEach { (button) in
                button.translatesAutoresizingMaskIntoConstraints = false
                addSubview(button)
            }
            
            NSLayoutConstraint.activate([
                buttons[0].topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
                buttons[0].leadingAnchor.constraint(equalTo: self.leadingAnchor),
                buttons[0].trailingAnchor.constraint(equalTo: self.trailingAnchor),
                buttons[0].heightAnchor.constraint(equalToConstant: 60)
            ])
            
            if buttons.count > 1 {
                for  index in 1...buttons.count - 1 {
                    NSLayoutConstraint.activate([
                        buttons[index].topAnchor.constraint(equalTo: buttons[index - 1].bottomAnchor, constant: 10),
                        buttons[index].leadingAnchor.constraint(equalTo: self.leadingAnchor),
                        buttons[index].trailingAnchor.constraint(equalTo: self.trailingAnchor),
                        buttons[index].heightAnchor.constraint(equalToConstant: 60)
                    ])
                }
            }
            
            bottomAnchor.constraint(equalTo: buttons[buttons.count - 1].bottomAnchor).isActive = true
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
