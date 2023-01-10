//
//  RatingStarsCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

extension RatingStarsViewController {
    final class RatingStarsCell: UITableViewCell {
        
        private let titleLabel = UILabel()
        private let ratingStarsView = RatingStarsView()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubviews(
                titleLabel,
                ratingStarsView
            )
            
            let inset: CGFloat = 16
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
                
                ratingStarsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: inset),
                ratingStarsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
                
                ratingStarsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(from model: RatingStarsModel) {
            titleLabel.text = model.title
            ratingStarsView.configure(from: model.score ?? 0)
        }
        
    }
}
