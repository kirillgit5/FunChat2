//
//  UIViewController + Extension.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 09.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

extension UIViewController {
     func configure<T: ConfiguringCell, U: Hashable>(collectionView: UICollectionView,cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("errror dequeueReusableCell") }
        cell.configure(with: value)
        return cell
    }
}
