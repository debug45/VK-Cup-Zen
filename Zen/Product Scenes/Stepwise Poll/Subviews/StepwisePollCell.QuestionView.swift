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
        
        private let barsStackView = UIStackView {
            $0.axis = .vertical
            $0.spacing = 8
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubviews(
                titleLabel,
                barsStackView
            )
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: topAnchor),
                
                barsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                barsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                barsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                barsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var someBarPressHandler: ((Int) -> Void)?
        
        func configure(with question: StepwisePollViewController.StepwisePollCell.Model.Question, index: Int) {
            titleLabel.text = "\(index + 1). \(question.title)"
            barsStackView.removeArrangedSubviews()
            
            question.answers.forEach { answer in
                let barView = BarView {
                    $0.title = answer.title
                    
                    var numberOfVotes = answer.numberOfVotes
                    var totalNumberOfVotes = question.answers.map(\.numberOfVotes).reduce(0, +)
                    
                    if answer.id == question.userAnswerID {
                        numberOfVotes += 1
                        totalNumberOfVotes += 1
                    }
                    
                    $0.numberOfVotes = numberOfVotes
                    $0.fillingMultiplier = CGFloat(numberOfVotes) / CGFloat(totalNumberOfVotes)
                    
                    let currentState: BarView.State
                    
                    if let userAnswerID = question.userAnswerID {
                        if answer.id == question.userAnswerID {
                            currentState = userAnswerID == question.correctAnswerID ? .correctAnswer : .incorrectAnswer
                        } else {
                            currentState = .anotherAnswer
                        }
                    } else {
                        currentState = .waitingForAnswer
                    }
                    
                    $0.currentState = currentState
                }
                
                let selector = #selector(someBarViewDidPress)
                barView.addTarget(self, action: selector, for: .touchUpInside)
                
                barsStackView.addArrangedSubview(barView)
            }
        }
        
        func animateBarsFilling() {
            barsStackView.arrangedSubviews.forEach {
                ($0 as? BarView)?.animateFilling()
            }
        }
        
        @objc private func someBarViewDidPress(_ sender: BarView) {
            guard let index = barsStackView.arrangedSubviews.firstIndex(of: sender) else {
                return
            }
            
            someBarPressHandler?(index)
        }
        
    }
}
