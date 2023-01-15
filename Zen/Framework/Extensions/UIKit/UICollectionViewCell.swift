//
//  UICollectionViewCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
    
}
