//
//  RatingStarsCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

final class RatingStarsViewControllerRatingStarsCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private var currentModel: Model?
    
    private let titleLabel = UILabel {
        $0.numberOfLines = 0
    }
    
    private lazy var ratingStarsView = RatingStarsView {
        $0.ratingChangeHandler = { [weak self] newValue in
            self?.currentModel?.score = newValue
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            titleLabel,
            ratingStarsView
        )
        
        let defaultInset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            ratingStarsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            ratingStarsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            ratingStarsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset - 2)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.title
        ratingStarsView.rating = model.score ?? 0
        
        currentModel = model
    }
    
}

extension RatingStarsViewController {
    typealias RatingStarsCell = RatingStarsViewControllerRatingStarsCell
}

extension RatingStarsViewController.RatingStarsCell {
    final class Model {
        
        let title: String
        var score: Double?
        
        init(title: String) {
            self.title = title
        }
        
    }
}
