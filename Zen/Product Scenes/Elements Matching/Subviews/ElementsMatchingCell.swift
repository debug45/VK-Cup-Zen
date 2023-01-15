//
//  ElementsMatchingCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 12.01.2023.
//

import UIKit

final class ElementsMatchingViewControllerElementsMatchingCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private var currentOptionViewMatches: [Model.Element: OptionView] = [:]
    
    private let titleLabel = UILabel {
        $0.font = .systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
        $0.numberOfLines = 0
        $0.textColor = .Zen.foreground
    }
    
    private let primaryStackView = UIStackView {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
    }
    
    private let secondaryStackView = UIStackView {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 8
    }
    
    private let resultStackView = UIStackView {
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private let checkResultButton = UIButton(type: .system).with {
        $0.setTitle(LocalizedStrings.Scene.ElementsMatching.checkButton, for: .normal)
        
        let titleColor = UIColor.Zen.accent
        $0.setTitleColor(titleColor, for: .normal)
        
        $0.setTitleColor(
            titleColor.withAlphaComponent(0.3),
            for: .disabled
        )
    }
    
    private let resultIconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        contentView.addSubviews(
            titleLabel,
            primaryStackView,
            secondaryStackView,
            
            resultStackView.addArrangedSubviews(
                checkResultButton,
                resultIconView
            )
        )
        
        let defaultInset: CGFloat = 20
        
        let lastVerticalConstraint = resultStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            primaryStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            secondaryStackView.topAnchor.constraint(equalTo: primaryStackView.topAnchor),
            secondaryStackView.bottomAnchor.constraint(equalTo: primaryStackView.bottomAnchor),
            
            primaryStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            secondaryStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            resultStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            resultStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -defaultInset),
            
            resultStackView.topAnchor.constraint(equalTo: primaryStackView.bottomAnchor, constant: 16),
            lastVerticalConstraint
        ])
        
        let selector = #selector(checkResultButtonDidPress)
        checkResultButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let model = model, let context = UIGraphicsGetCurrentContext() else {
            return
        }
            
        for (primaryElement, secondaryElement) in model.userPairs {
            guard
                let primaryView = currentOptionViewMatches[primaryElement],
                let secondaryView = currentOptionViewMatches[secondaryElement]
            else {
                continue
            }
            
            context.setStrokeColor(UIColor.Zen.accent.cgColor)
            
            context.setLineCap(.round)
            context.setLineWidth(1.5)
            
            context.beginPath()
            
            let primaryFrame = primaryView.convert(primaryView.bounds, to: contentView)
            let secondaryFrame = secondaryView.convert(secondaryView.bounds, to: contentView)
            
            let inset: CGFloat = 8
            
            context.move(
                to: .init(x: primaryFrame.maxX + inset, y: primaryFrame.midY)
            )
            
            context.addLine(
                to: .init(x: secondaryFrame.minX - inset, y: secondaryFrame.midY)
            )
            
            context.strokePath()
        }
    }
    
    var model: Model? {
        didSet {
            guard let model else {
                return
            }
            
            titleLabel.text = model.title
            reconfigureElementViews()
            
            updateCheckResultButton()
            updateVisibleResult()
        }
    }
    
    private func reconfigureElementViews() {
        currentOptionViewMatches = [:]
        
        primaryStackView.removeArrangedSubviews()
        secondaryStackView.removeArrangedSubviews()
        
        guard let model else {
            return
        }
        
        for (elements, stackView) in [
            (model.primaryElements, primaryStackView),
            (model.secondaryElements, secondaryStackView)
        ] {
            elements.forEach { element in
                let optionView = OptionView {
                    $0.title = element.title
                }
                
                var selector = #selector(panGestureDidRecognize)
                
                optionView.addGestureRecognizer(
                    UIPanGestureRecognizer(target: self, action: selector)
                )
                
                selector = #selector(someOptionViewDidTap)
                optionView.addTarget(self, action: selector, for: .touchUpInside)
                
                stackView.addArrangedSubview(optionView)
                currentOptionViewMatches[element] = optionView
            }
        }
        
        updateVisibleSelection()
        setNeedsDisplay()
    }
    
    private func updateVisibleSelection() {
        guard let model else {
            return
        }
        
        currentOptionViewMatches.forEach { element, view in
            view.isSelected = element == model.selectedElement
        }
    }
    
    private func updateCheckResultButton() {
        guard let model else {
            return
        }
        
        checkResultButton.isEnabled = model.userPairs.count == model.pairs.count
    }
    
    private func updateVisibleResult() {
        if let actualCheckResult = model?.actualCheckResult {
            resultIconView.isHidden = false
            
            if actualCheckResult {
                resultIconView.image = .init(systemName: "checkmark.circle.fill")
                resultIconView.tintColor = .green
            } else {
                resultIconView.image = .init(systemName: "xmark.circle.fill")
                resultIconView.tintColor = .red
            }
        } else {
            resultIconView.isHidden = true
        }
    }
    
    @objc private func someOptionViewDidTap(_ sender: OptionView) {
        let firstView = sender
        
        guard let model, let firstElement = currentOptionViewMatches.first(where: { $0.value == firstView })?.key else {
            return
        }
        
        if let secondElement = model.selectedElement {
            guard firstElement != secondElement, let secondView = currentOptionViewMatches[secondElement] else {
                return
            }
            
            if firstView.superview == secondView.superview {
                model.selectedElement = firstElement
            } else {
                let outdatedUserPairs = model.userPairs.compactMap { key, value in
                    return [firstElement, secondElement].contains(where: { $0 == key || $0 == value }) ? key : nil
                }
                
                outdatedUserPairs.forEach {
                    model.userPairs.removeValue(forKey: $0)
                }
                
                var firstElement = firstElement
                var secondElement = secondElement
                
                if primaryStackView.arrangedSubviews.contains(secondView) || secondaryStackView.arrangedSubviews.contains(firstView) {
                    (firstElement, secondElement) = (secondElement, firstElement)
                }
                
                model.userPairs[firstElement] = secondElement
                
                model.selectedElement = nil
                model.actualCheckResult = nil
                
                setNeedsDisplay()
                
                updateCheckResultButton()
                updateVisibleResult()
            }
        } else {
            model.selectedElement = firstElement
        }
        
        updateVisibleSelection()
    }
    
    @objc private func panGestureDidRecognize(_ sender: UIPanGestureRecognizer) {
        guard let optionView = sender.view as? OptionView, let parentStackView = optionView.superview as? UIStackView else {
            return
        }
        
        let animatingDuration: TimeInterval = 0.25
        
        switch sender.state {
            case .began:
                model?.selectedElement = currentOptionViewMatches.first(where: { $0.value == optionView })?.key
                updateVisibleSelection()
                
            case .changed:
                parentStackView.superview?.bringSubviewToFront(parentStackView)
                optionView.superview?.bringSubviewToFront(optionView)
                
                let translation = sender.translation(in: optionView)
                optionView.transform = .init(translationX: translation.x, y: translation.y)
                
                let frame = optionView.convert(optionView.bounds, to: contentView)
                
                if frame.minY < 0 || frame.maxY > contentView.bounds.height {
                    sender.releaseCurrentGesture()
                    optionView.transform = .init(translationX: translation.x, y: translation.y)
                    
                    UIView.animate(withDuration: animatingDuration) {
                        optionView.transform = .identity
                    }
                }
                
            case .ended:
                let anotherStackView = parentStackView == primaryStackView ? secondaryStackView : primaryStackView
                var correspondingOptionView: OptionView?
            
                for anotherOptionView in anotherStackView.arrangedSubviews {
                    let point = sender.location(in: anotherOptionView)
                    
                    if anotherOptionView.bounds.contains(point) {
                        correspondingOptionView = anotherOptionView as? OptionView
                        break
                    }
                }
                
                UIView.animate(withDuration: animatingDuration, animations: {
                    optionView.transform = .identity
                }) { isFinished in
                    guard isFinished, let correspondingOptionView else {
                        return
                    }
                    
                    self.someOptionViewDidTap(correspondingOptionView)
                }
                
                default:
                    optionView.transform = .identity
        }
    }
    
    @objc private func checkResultButtonDidPress() {
        guard let model else {
            return
        }
        
        model.actualCheckResult = model.pairs.allSatisfy { model.userPairs[$0.key] == $0.value }
        updateVisibleResult()
    }
    
}

extension ElementsMatchingViewController {
    typealias ElementsMatchingCell = ElementsMatchingViewControllerElementsMatchingCell
}

extension ElementsMatchingViewController.ElementsMatchingCell {
    final class Model {
        
        let title: String
        let pairs: [Element: Element]
        
        private(set) lazy var primaryElements = pairs.keys.shuffled()
        private(set) lazy var secondaryElements = pairs.values.shuffled()
        
        var selectedElement: Element?
        var userPairs: [Element: Element] = [:]
        
        var actualCheckResult: Bool?
        
        init(title: String, pairs: [Element: Element]) {
            self.title = title
            self.pairs = pairs
        }
        
        struct Element: Hashable {
            
            let id: String
            let title: String
            
            init(id: String, title: String) {
                self.id = id
                self.title = title
            }
            
        }
        
    }
}
