//
//  StepwisePollCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

final class StepwisePollViewControllerStepwisePollCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private let titleLabel = UILabel {
        $0.alpha = 0.5
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.textColor = .Zen.foreground
    }
    
    private lazy var questionView = QuestionView {
        $0.someBarPressHandler = { [weak self] index in
            self?.handleUserAnswer(index: index)
        }
    }
    
    private let nextButton = UIButton(type: .system).with {
        $0.setTitle(LocalizedStrings.Scene.StepwisePoll.nextButton, for: .normal)
        
        $0.setTitleColor(.Zen.accent, for: .normal)
        $0.setTitleColor(.Zen.accent.withAlphaComponent(0.3), for: .disabled)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            titleLabel,
            questionView,
            nextButton
        )
        
        let defaultInset: CGFloat = 20
        
        let lastVerticalConstraint = nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            questionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            questionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            questionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            
            nextButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            nextButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -defaultInset),
            
            nextButton.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 16),
            lastVerticalConstraint
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: Model? {
        didSet {
            titleLabel.text = model?.title
            reconfigureQuestionView()
        }
    }
    
    private func reconfigureQuestionView() {
        guard let model else {
            return
        }
        
        let currentQuestionIndex = model.currentQuestionIndex
        let question = model.questions[currentQuestionIndex]
        
        questionView.configure(
            with: question,
            index: currentQuestionIndex
        )
        
        nextButton.isEnabled = question.userAnswerID != nil
    }
    
    private func handleUserAnswer(index: Int) {
        guard let model else {
            return
        }
        
        let question = model.questions[model.currentQuestionIndex]
        question.userAnswerID = question.answers[index].id
        
        reconfigureQuestionView()
        questionView.animateBarsFilling()
        
        nextButton.isEnabled = true
    }
    
}

extension StepwisePollViewController {
    typealias StepwisePollCell = StepwisePollViewControllerStepwisePollCell
}

extension StepwisePollViewController.StepwisePollCell {
    final class Model {
        
        let title: String
        let questions: [Question]
        
        var currentQuestionIndex = 0
        
        init(title: String, questions: [Question]) {
            self.title = title
            self.questions = questions
        }
        
        final class Question {
            
            let title: String
            
            let answers: [Answer]
            let correctAnswerID: String
            
            var userAnswerID: String?
            
            init(title: String, answers: [Answer], correctAnswerID: String) {
                self.title = title
                self.answers = answers
                self.correctAnswerID = correctAnswerID
            }
            
            final class Answer {
                
                let id: String
                let title: String
                let numberOfVotes: Int
                
                init(id: String, title: String, numberOfVotes: Int) {
                    self.id = id
                    self.title = title
                    self.numberOfVotes = numberOfVotes
                }
                
            }
            
        }
        
    }
}
