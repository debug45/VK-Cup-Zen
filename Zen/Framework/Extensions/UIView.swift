//
//  UIView.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

extension UIView: Withable {
    
    @discardableResult
    func addSubviews(_ subviews: UIView...) -> UIView {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        return self
    }
    
}
