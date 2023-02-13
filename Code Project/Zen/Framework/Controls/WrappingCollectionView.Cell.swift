//
//  WrappingCollectionView.Cell.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension WrappingCollectionView {
    final class Cell: UICollectionViewCell {
        
        var content: UIView? {
            didSet {
                oldValue?.removeFromSuperview()
                
                guard let content else {
                    return
                }
                
                contentView.addSubviews(content)
                
                let lastHorizontalConstraint = content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                lastHorizontalConstraint.priority = .defaultHigh
                
                NSLayoutConstraint.activate([
                    content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    lastHorizontalConstraint,
                    
                    content.topAnchor.constraint(equalTo: contentView.topAnchor),
                    content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])
            }
        }
        
    }
}
