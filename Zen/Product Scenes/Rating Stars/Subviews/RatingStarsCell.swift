//
//  RatingStarsCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

extension RatingStarsViewController {
    final class RatingStarsCell: UITableViewCell {
        
        private let titleLabel = UILabel {
            $0.numberOfLines = 0
        }
        
        private lazy var ratingStarsView = RatingStarsView {
            $0.ratingChangeHandler = { [weak self] newValue in
                self?.ratingChangeHandler?(newValue)
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
        
        var ratingChangeHandler: ((Double) -> Void)?
        
        func configure(from model: RatingStarsModel) {
            titleLabel.text = model.title
            ratingStarsView.rating = model.score ?? 0
        }
        
    }
}
