//
//  StepwisePollCell.QuestionView.BarView.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension StepwisePollViewController.StepwisePollCell.QuestionView {
    final class BarView: UIControl {
        
        private let titleLabel = UILabel {
            $0.textColor = .Zen.foreground
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .Zen.foreground.withAlphaComponent(0.1)
            layer.cornerRadius = 4
            
            addSubviews(
                titleLabel
            )
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
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
