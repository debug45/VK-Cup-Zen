//
//  StepwisePollCell.QuestionView.BarView.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension StepwisePollViewController.StepwisePollCell.QuestionView {
    final class BarView: UIControl {
        
        private let fillerView = UIView {
            $0.isUserInteractionEnabled = false
        }
        
        private let titleLabel = UILabel {
            $0.textColor = .Zen.foreground
        }
        
        private let trailingContainerView = UIStackView {
            $0.alignment = .center
            $0.isUserInteractionEnabled = false
            $0.spacing = 8
        }
        
        private let stateIconView = UIImageView {
            $0.tintColor = .Zen.foreground
        }
        
        private let percentOfVotesLabel = UILabel {
            $0.font = .systemFont(ofSize: 14)
        }
        
        private var fillerViewWidthConstraint: NSLayoutConstraint?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .Zen.foreground.withAlphaComponent(0.1)
            layer.cornerRadius = 4
            
            addSubviews(
                fillerView,
                titleLabel,
                
                trailingContainerView.addArrangedSubviews(
                    stateIconView,
                    percentOfVotesLabel
                )
            )
            
            let defaultInset: CGFloat = 12
            
            NSLayoutConstraint.activate([
                fillerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                fillerView.topAnchor.constraint(equalTo: topAnchor),
                fillerView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultInset),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultInset),
                
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
                
                trailingContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultInset),
                
                trailingContainerView.topAnchor.constraint(equalTo: topAnchor),
                trailingContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            updateFillerWidth()
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
        
        var percentOfVotes: String? {
            didSet {
                percentOfVotesLabel.text = percentOfVotes
            }
        }
        
        var currentState: State? {
            didSet {
                var isEnabled = false
                var titleFontWeight = UIFont.Weight.regular
                
                var fillerColor: UIColor?
                var stateIcon: UIImage?
                
                switch currentState {
                    case .waitingForAnswer:
                        isEnabled = true
                        
                    case .anotherAnswer:
                        fillerColor = .Zen.foreground.withAlphaComponent(0.1)
                        
                    case .correctAnswer:
                        titleFontWeight = .bold
                        
                        fillerColor = .green.withAlphaComponent(0.5)
                        stateIcon = .init(systemName: "hand.thumbsup")
                        
                    case .incorrectAnswer:
                        titleFontWeight = .bold
                        
                        fillerColor = .red.withAlphaComponent(0.5)
                        stateIcon = .init(systemName: "hand.thumbsdown")
                        
                    case nil:
                        return
                }
                
                self.isEnabled = isEnabled
                
                let size = UIFont.systemFontSize
                titleLabel.font = .systemFont(ofSize: size, weight: titleFontWeight)
                
                trailingContainerView.isHidden = currentState == .waitingForAnswer
                
                fillerView.backgroundColor = fillerColor
                stateIconView.image = stateIcon
            }
        }
        
        var fillingMultiplier: CGFloat? {
            didSet {
                updateFillerWidth()
            }
        }
        
        func animateFilling() {
            updateFillerWidth(multiplier: 0)
            layoutIfNeeded()
            
            UIView.animate(withDuration: 0.5) {
                self.updateFillerWidth()
                self.layoutIfNeeded()
            }
        }
        
        private func updateFillerWidth(multiplier: CGFloat? = nil) {
            fillerViewWidthConstraint?.isActive = false
            
            if let multiplier = multiplier ?? fillingMultiplier {
                fillerViewWidthConstraint = fillerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier)
                fillerViewWidthConstraint?.isActive = true
            }
        }
        
    }
}

extension StepwisePollViewController.StepwisePollCell.QuestionView.BarView {
    enum State {
        
        case waitingForAnswer
        case anotherAnswer
        
        case correctAnswer
        case incorrectAnswer
        
    }
}
