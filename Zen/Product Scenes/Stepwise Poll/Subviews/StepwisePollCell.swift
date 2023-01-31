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
    
    private let questionsStackView = UIStackView {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    private lazy var currentQuestionView = QuestionView {
        $0.someBarPressHandler = { [weak self] index in
            self?.handleUserAnswer(index: index)
        }
    }
    
    private let commitButton = UIButton(type: .system).with {
        $0.setTitleColor(.Zen.accent, for: .normal)
        
        $0.setTitleColor(
            .Zen.accent.withAlphaComponent(0.3),
            for: .disabled
        )
    }
    
    private let resultsLabel = UILabel {
        $0.font = .systemFont(ofSize: 100, weight: .bold)
        $0.textColor = .Zen.foreground
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            titleLabel,
            
            questionsStackView.addArrangedSubviews(
                currentQuestionView,
                commitButton
            ),
            
            resultsLabel
        )
        
        let defaultInset: CGFloat = 20
        
        let lastVerticalConstraint = questionsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            questionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            questionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            questionsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            lastVerticalConstraint,
            
            currentQuestionView.widthAnchor.constraint(equalTo: questionsStackView.widthAnchor),
            
            resultsLabel.centerXAnchor.constraint(equalTo: questionsStackView.centerXAnchor),
            resultsLabel.centerYAnchor.constraint(equalTo: questionsStackView.centerYAnchor)
        ])
        
        let selector = #selector(commitButtonDidPress)
        commitButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var availableWidth: CGFloat?
    
    weak var delegate: InteractiveFormatViewController.ItemCell.Delegate?
    
    var model: Model? {
        didSet {
            titleLabel.text = model?.title
            
            updateMainViews()
            reconfigureCurrentQuestionView()
            
            updateCommitButton()
            updateResultsLabel()
        }
    }
    
    private func updateMainViews() {
        guard let model else {
            return
        }
        
        questionsStackView.isHidden = model.currentQuestionIndex >= model.questions.count
        resultsLabel.isHidden = !questionsStackView.isHidden
    }
    
    private func reconfigureCurrentQuestionView() {
        guard let model else {
            return
        }
        
        let currentQuestionIndex = model.currentQuestionIndex < model.questions.count ? model.currentQuestionIndex : 0
        let question = model.questions[currentQuestionIndex]
        
        currentQuestionView.configure(
            with: question,
            index: currentQuestionIndex
        )
    }
    
    private func updateCommitButton() {
        guard !questionsStackView.isHidden, let model else {
            return
        }
        
        let strings = LocalizedStrings.Scene.StepwisePoll.CommitButton.self
        
        commitButton.setTitle(
            model.currentQuestionIndex < model.questions.count - 1 ? strings.nextQuestion : strings.showResults,
            for: .normal
        )
        
        commitButton.isEnabled = model.questions[model.currentQuestionIndex].userAnswerID != nil
    }
    
    private func updateResultsLabel() {
        guard !resultsLabel.isHidden, let model else {
            return
        }
        
        let numberOfCorrectlyAnswered = model.questions.filter({ $0.userAnswerID == $0.correctAnswerID }).count
        
        resultsLabel.text = Instances.percentFormatter.string(
            from: .init(
                value: Double(numberOfCorrectlyAnswered) / Double(model.questions.count)
            )
        )?.replacingOccurrences(of: " ", with: "\u{2009}")
    }
    
    private func handleUserAnswer(index: Int) {
        guard let model else {
            return
        }
        
        let question = model.questions[model.currentQuestionIndex]
        question.userAnswerID = question.answers[index].id
        
        reconfigureCurrentQuestionView()
        currentQuestionView.animateBarsFilling()
        
        updateCommitButton()
    }
    
    @objc private func commitButtonDidPress(_ sender: Any) {
        guard let model else {
            return
        }
        
        let animatingDuration: TimeInterval = 0.25
        let translation: CGFloat = 20
        
        UIView.animate(withDuration: animatingDuration, delay: 0, options: .curveEaseIn, animations: {
            self.questionsStackView.alpha = 0
            self.questionsStackView.transform = .init(translationX: -translation, y: 0)
        }, completion: { isFinished in
            guard isFinished else {
                return
            }
            
            model.currentQuestionIndex += 1
            
            self.updateMainViews()
            self.reconfigureCurrentQuestionView()
            
            UIView.performWithoutAnimation {
                self.updateCommitButton()
                self.contentView.layoutIfNeeded()
            }
            
            self.updateResultsLabel()
            
            let mainViews = [
                self.questionsStackView,
                self.resultsLabel
            ]
            
            mainViews.forEach {
                $0.alpha = 0
                $0.transform = .init(translationX: translation, y: 0)
            }
            
            UIView.animate(withDuration: animatingDuration, delay: 0, options: .curveEaseOut) {
                mainViews.forEach {
                    $0.alpha = 1
                    $0.transform = .identity
                }
            }
        })
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
