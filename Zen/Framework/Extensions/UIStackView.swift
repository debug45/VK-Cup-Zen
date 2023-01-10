//
//  UIView.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

extension UIStackView {
    
    @discardableResult
    func addArrangedSubviews(_ subviews: UIView...) -> UIView {
        return addArrangedSubviews(subviews)
    }

    @discardableResult
    func addArrangedSubviews(_ subviews: [UIView]) -> UIView {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = true
            addArrangedSubview($0)
        }
        
        return self
    }
    
}
