//
//  AddPhotoView.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 25.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class AddPhotoView: UIView {
    
    private let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    private let plusButton: UIButton = {
       let buttton = UIButton()
        buttton.translatesAutoresizingMaskIntoConstraints = false
        buttton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        buttton.tintColor = .getBlackColor()
        return buttton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(circleImageView)
        self.addSubview(plusButton)
        
    
        
        
    }
    
    private func setupConstrains() {
        
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
