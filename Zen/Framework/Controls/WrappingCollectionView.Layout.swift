//
//  WrappingCollectionView.Layout.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension WrappingCollectionView {
    final class Layout: UICollectionViewLayout {
        
        // TODO: Support different writing directions (`developmentLayoutDirection`)
        
        private var calculatedParameters: (layoutAttributes: [UICollectionViewLayoutAttributes], contentSize: CGSize)?
        private weak var delegate: Delegate?
        
        init(delegate: Delegate) {
            super.init()
            self.delegate = delegate
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var collectionViewContentSize: CGSize {
            return calculatedParameters?.contentSize ?? .init()
        }
        
        var availableWidth: CGFloat?
        
        override func prepare() {
            guard let collectionView = collectionView, let delegate = delegate else {
                return
            }
            
            let availableWidth = availableWidth ?? collectionView.bounds.width
            let interitemSpacing = delegate.getInteritemSpacing()
            
            var layoutAttributes: [UICollectionViewLayoutAttributes] = []
            var contentSize = CGSize.zero
            
            var currentPosition = CGPoint.zero
            var currentLineHeight: CGFloat = 0
            
            let sectionIndex = 0
            
            for itemIndex in 0 ..< collectionView.numberOfItems(inSection: sectionIndex) {
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                
                if currentPosition.x > 0 {
                    currentPosition.x += interitemSpacing.width
                }
                
                let size = delegate.getSizeForItem(at: indexPath)
                
                if currentPosition.x + size.width > availableWidth {
                    currentPosition.x = 0
                    currentPosition.y += currentLineHeight + interitemSpacing.height
                    
                    currentLineHeight = 0
                }
                
                let frame = CGRect(origin: currentPosition, size: size)
                
                let currentAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                currentAttributes.frame = frame
                
                layoutAttributes.append(currentAttributes)
                
                contentSize.width = max(contentSize.width, frame.maxX)
                contentSize.height = max(contentSize.height, frame.maxY)
                
                currentPosition.x += frame.width
                currentLineHeight = max(currentLineHeight, frame.height)
            }
            
            calculatedParameters = (layoutAttributes: layoutAttributes, contentSize: contentSize)
        }
        
        override func invalidateLayout() {
            calculatedParameters = nil
        }
        
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            return calculatedParameters?.layoutAttributes.filter { $0.frame.intersects(rect) }
        }
        
        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            return calculatedParameters?.layoutAttributes[indexPath.item]
        }
        
    }
}
