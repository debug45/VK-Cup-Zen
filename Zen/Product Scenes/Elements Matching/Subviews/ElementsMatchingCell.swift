//
//  ElementsMatchingCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 12.01.2023.
//

import UIKit

extension ElementsMatchingViewController {
    final class ElementsMatchingCell: UITableViewCell {
        
        private let titleLabel = UILabel {
            $0.font = .systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
            $0.numberOfLines = 0
        }
        
        private let firstStackView = UIStackView {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 8
        }
        
        private let secondStackView = UIStackView {
            $0.axis = .vertical
            $0.alignment = .trailing
            $0.spacing = 8
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubviews(
                titleLabel,
                firstStackView,
                secondStackView
            )
            
            let defaultInset: CGFloat = 20
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                
                firstStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                firstStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset),
                
                secondStackView.topAnchor.constraint(equalTo: firstStackView.topAnchor),
                secondStackView.bottomAnchor.constraint(equalTo: firstStackView.bottomAnchor),
                
                firstStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
                secondStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset)
            ])
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(from model: ElementsMatchingModel) {
            titleLabel.text = model.title
            
            firstStackView.removeAllArrangedSubviews()
            secondStackView.removeAllArrangedSubviews()
            
            let keys = model.data.keys.shuffled()
            let values = model.data.values.shuffled()
            
            keys.forEach { title in
                let optionView = OptionView {
                    $0.title = title
                }
                
                firstStackView.addArrangedSubview(optionView)
            }
            
            values.forEach { title in
                let optionView = OptionView {
                    $0.title = title
                }
                
                secondStackView.addArrangedSubview(optionView)
            }
        }
        
    }
}
