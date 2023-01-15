//
//  StepwisePollCell.QuestionView.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension StepwisePollViewController.StepwisePollCell {
    final class QuestionView: UIView {
        
        private let titleLabel = UILabel {
            $0.font = .systemFont(ofSize: 22, weight: .bold)
            $0.numberOfLines = 0
            $0.textColor = .Zen.foreground
        }
        
        private let answersStackView = UIStackView {
            $0.axis = .vertical
            $0.spacing = 8
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubviews(
                titleLabel,
                answersStackView
            )
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: topAnchor),
                
                answersStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                answersStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                answersStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                answersStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(with question: StepwisePollViewController.StepwisePollCell.Model.Question, index: Int) {
            titleLabel.text = "\(index + 1). \(question.title)"
            answersStackView.removeArrangedSubviews()
            
            question.answers.forEach { answer in
                let barView = BarView {
                    $0.title = answer.title
                }
                
                answersStackView.addArrangedSubview(barView)
            }
        }
        
    }
}
