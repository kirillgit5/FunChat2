//
//  UIStackView + Extension.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 25.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(subViews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: subViews)
        self.axis = axis
        self.spacing = spacing
    }
}
