//
//  WrappingCollectionView.Layout.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension WrappingCollectionView {
    final class Layout: UICollectionViewFlowLayout {
        
        override init() {
            super.init()
            
            minimumInteritemSpacing = 4
            minimumLineSpacing = 4
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let attributes = super.layoutAttributesForElements(in: rect) else {
                return nil
            }
            
            var x: CGFloat = 0
            var y: CGFloat = 0
            
            for attribute in attributes {
                if attribute.frame.minY > y {
                    x = 0
                    y = attribute.frame.minY
                }
                
                attribute.frame.origin.x = x
                x += attribute.frame.width + minimumInteritemSpacing
            }
            
            return attributes
        }
        
    }
}
