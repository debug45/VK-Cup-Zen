//
//  WrappingCollectionView.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

final class WrappingCollectionView: UIView {
    
    private lazy var collectionViewLayout = Layout(delegate: self)
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).with {
        $0.backgroundColor = nil
        $0.clipsToBounds = false
        
        $0.allowsSelection = false
        $0.isScrollEnabled = false
        
        $0.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(
            collectionView
        )
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var availableWidth: CGFloat? {
        get {
            return collectionViewLayout.availableWidth
        } set {
            collectionViewLayout.availableWidth = newValue
        }
    }
    
    var children: [(view: UIView, size: CGSize)] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var contentSize: CGSize {
        return collectionView.contentSize
    }
    
    var interitemSpacing = CGSize.zero
    
}

extension WrappingCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return .init()
        }
        
        cell.content = children[indexPath.row].view
        return cell
    }
    
}

extension WrappingCollectionView: WrappingCollectionViewLayoutDelegate {
    
    func getSizeForItem(at indexPath: IndexPath) -> CGSize {
        return children[indexPath.item].size
    }
    
    func getInteritemSpacing() -> CGSize {
        return interitemSpacing
    }
    
}
