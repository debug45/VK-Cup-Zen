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
    
    private let questionView = QuestionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            titleLabel,
            questionView
        )
        
        let defaultInset: CGFloat = 20
        
        let lastVerticalConstraint = questionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            questionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            questionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            questionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            lastVerticalConstraint
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: Model? {
        didSet {
            guard let model, let firstQuestion = model.questions.first else {
                return
            }
            
            titleLabel.text = model.title
            questionView.configure(with: firstQuestion, index: 0)
        }
    }
    
}

extension StepwisePollViewController {
    typealias StepwisePollCell = StepwisePollViewControllerStepwisePollCell
}

extension StepwisePollViewController.StepwisePollCell {
    final class Model {
        
        let title: String
        let questions: [Question]
        
        init(title: String, questions: [Question]) {
            self.title = title
            self.questions = questions
        }
        
        struct Question {
            
            let title: String
            
            let answers: [Answer]
            let correctAnswerID: String
            
            struct Answer {
                
                let id: String
                let title: String
                let numberOfVotes: Int
                
            }
            
        }
        
    }
}
