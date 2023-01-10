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
            
            let inset: CGFloat = 16
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(title: String) {
            titleLabel.text = title
        }
        
    }
}
