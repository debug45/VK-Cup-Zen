//
//  ElementsMixingCell.OptionView.swift
//  Zen
//
//  Created by Sergey Moskvin on 29.01.2023.
//

import UIKit

extension ElementsMixingViewController.ElementsMixingCell {
    final class OptionView: UIControl {
        
        let titleFont = UIFont.systemFont(ofSize: 17)
        let titleHorizontalInset: CGFloat = 8
        
        private lazy var titleLabel = UILabel {
            $0.font = titleFont
            $0.textAlignment = .center
            $0.textColor = .Zen.foreground
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .Zen.background
            
            layer.borderColor = UIColor.Zen.foreground.cgColor
            layer.borderWidth = 1.5
            
            layer.cornerRadius = 12
            
            addSubviews(
                titleLabel
            )
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleHorizontalInset),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -titleHorizontalInset),
                
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: -1),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ])
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var isHighlighted: Bool {
            didSet {
                alpha = isHighlighted ? 0.5 : 1
            }
        }
        
        var title: String {
            get {
                return titleLabel.text ?? ""
            } set {
                titleLabel.text = newValue
            }
        }
        
    }
}
