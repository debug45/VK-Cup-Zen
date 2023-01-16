//
//  SimpleTextGapsCell.OptionView.swift
//  Zen
//
//  Created by Sergey Moskvin on 16.01.2023.
//

import UIKit

extension SimpleTextGapsViewController.SimpleTextGapsCell {
    final class OptionView: UIControl {
        
        static let titleFont = UIFont.systemFont(ofSize: 17)
        static let titleHorizontalInset: CGFloat = 8
        
        private lazy var titleLabel = UILabel {
            $0.font = Self.titleFont
            $0.textAlignment = .center
            $0.textColor = .Zen.foreground
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .Zen.background
            
            layer.borderWidth = 1.5
            layer.cornerRadius = 12
            
            addSubviews(
                titleLabel
            )
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Self.titleHorizontalInset),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Self.titleHorizontalInset),
                
                titleLabel.topAnchor.constraint(equalTo: topAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
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
        
        override var isSelected: Bool {
            didSet {
                updateLayout()
            }
        }
        
        var title: String {
            get {
                return titleLabel.text ?? ""
            } set {
                titleLabel.text = newValue
            }
        }
        
        var isTemplate: Bool? {
            didSet {
                updateLayout()
            }
        }
        
        private func updateLayout() {
            let colors = UIColor.Zen.self
            
            if isSelected {
                layer.borderColor = colors.accent.cgColor
            } else {
                layer.borderColor = (
                    colors.foreground.withAlphaComponent(isTemplate == true ? 0.25 : 1)
                ).cgColor
            }
            
            titleLabel.alpha = isTemplate == true ? 0 : 1
        }
        
    }
}
