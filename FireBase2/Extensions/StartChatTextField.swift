//
//  StartChatTextField.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 09.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class StrartChatTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customTextField() {
        backgroundColor = .white
        placeholder = "wrtite something here..."
        font = UIFont.getFontlaoSangamMN14()
        clearButtonMode = .whileEditing
        layer.cornerRadius = 18
        layer.masksToBounds = true
        borderStyle = .none
        
        let leftImageView = UIImageView(image: UIImage(systemName: "smiley"))
        leftImageView.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        leftImageView.setupColor(color: .lightGray)
        leftView = leftImageView
        leftViewMode = .always
        
        let rightButton = UIButton(type: .system)
        rightButton.setImage(UIImage(named: "Sent"), for: .normal)
        rightButton.setupGradients(cornerRadius: 10)

        
        rightView = rightButton
        rightButton.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        rightViewMode = .always
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 12
        return rect
    }
}
