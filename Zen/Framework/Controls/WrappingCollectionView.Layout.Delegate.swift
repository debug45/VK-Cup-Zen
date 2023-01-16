//
//  WrappingCollectionView.Layout.Delegate.swift
//  Zen
//
//  Created by Sergey Moskvin on 16.01.2023.
//

import UIKit

protocol WrappingCollectionViewLayoutDelegate: AnyObject {
    
    func getSizeForItem(at indexPath: IndexPath) -> CGSize
    func getInteritemSpacing() -> CGSize
    
}

extension WrappingCollectionView.Layout {
    typealias Delegate = WrappingCollectionViewLayoutDelegate
}
