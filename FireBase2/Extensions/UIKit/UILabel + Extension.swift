//
//  UILabel + Extension.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 25.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .getFontAvenir20()) {
        self.init()
        self.text = text
        self.font = font
    }
}
