//
//  UITableViewCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
    
}
