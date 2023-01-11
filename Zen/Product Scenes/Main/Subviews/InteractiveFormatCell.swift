//
//  InteractiveFormatCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

import UIKit

extension MainViewController {
    final class InteractiveFormatCell: UITableViewCell {
        
        private let titleLabel = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubviews(
                titleLabel
            )
            
            let defaultInset: CGFloat = 20
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(title: String) {
            titleLabel.text = title
        }
        
    }
}
