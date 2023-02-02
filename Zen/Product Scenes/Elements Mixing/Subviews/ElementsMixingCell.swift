//
//  ElementsMixingCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 29.01.2023.
//

import UIKit

final class ElementsMixingViewControllerElementsMixingCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private let animatingDuration: TimeInterval = 0.25
    private let holeWidth: CGFloat = 92
    
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    private let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    private var currentOptionViews: [OptionView] = []
    
    private let titleLabel = UILabel {
        let size = UIFont.systemFontSize
        $0.font = .systemFont(ofSize: size, weight: .bold)
        
        $0.numberOfLines = 0
        $0.textColor = .Zen.foreground
    }
    
    private let helpButton = UIButton(type: .system).with {
        $0.setImage(
            .init(systemName: "info.circle"),
            for: .normal
        )
    }
    
    private let statesContainerView = UIView()
    
    private let holeContainerView = UIView()
    
    private let holeLabel = UILabel {
        $0.font = .systemFont(ofSize: 96)
        
        $0.text = "🕳️"
        $0.textAlignment = .center
    }
    
    private let addedCountLabel = UILabel {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private let wrappingCollectionViewContainer = UIView {
        $0.backgroundColor = .Zen.foreground.withAlphaComponent(0.1)
        $0.layer.cornerRadius = 12
    }
    
    private let hintLabel = UILabel()
    
    private let wrappingCollectionView = WrappingCollectionView {
        $0.interitemSpacing = .init(8)
    }
    
    private let resultContainer = UIView()
    private let resultNestedContainer = UIView()
    
    private let resultIconLabel = UILabel {
        $0.font = .systemFont(ofSize: 96)
        $0.textAlignment = .center
    }
    
    private let resultTitleLabel = UILabel {
        $0.font = .systemFont(ofSize: 34, weight: .bold)
        
        $0.textAlignment = .center
        $0.textColor = .Zen.foreground.withAlphaComponent(0.5)
    }
    
    private let checkResultStackView = UIStackView {
        $0.alignment = .center
        $0.spacing = 4
    }
    
    private let checkResultButton = UIButton(type: .system).with {
        $0.setTitle(LocalizedStrings.Scene.ElementsMixing.CheckResult.button, for: .normal)
    }
    
    private let checkResultHintLabel = UILabel {
        $0.font = .systemFont(ofSize: 15)
        
        let deviceClassName = UIDevice.current.className
        $0.text = LocalizedStrings.Scene.ElementsMixing.CheckResult.hint(deviceClassName: deviceClassName)
        
        $0.textColor = .Zen.foreground.withAlphaComponent(0.5)
    }
    
    private let resetButton = UIButton(type: .system).with {
        $0.setTitle(LocalizedStrings.Scene.ElementsMixing.resetButton, for: .normal)
    }
    
    private var wrappingCollectionViewContainerLeadingConstraint: NSLayoutConstraint!
    private var wrappingCollectionViewContainerTrailingConstraint: NSLayoutConstraint!
    
    private var wrappingCollectionViewLeadingConstraint: NSLayoutConstraint!
    private var wrappingCollectionViewTrailingConstraint: NSLayoutConstraint!
    
    private var wrappingCollectionViewHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        contentView.addSubviews(
            titleLabel,
            helpButton,
            
            statesContainerView.addSubviews(
                holeContainerView.addSubviews(
                    holeLabel,
                    addedCountLabel
                ),
                
                wrappingCollectionViewContainer.addSubviews(
                    hintLabel,
                    wrappingCollectionView
                ),
                
                resultContainer.addSubviews(
                    resultNestedContainer.addSubviews(
                        resultIconLabel,
                        resultTitleLabel
                    )
                ),
                
                checkResultStackView.addArrangedSubviews(
                    checkResultButton,
                    checkResultHintLabel,
                    resetButton
                )
            )
        )
        
        let defaultInset: CGFloat = 20
        
        let elementsContainerInset: CGFloat = 12
        let holeContainerInset: CGFloat = 12
        
        wrappingCollectionViewContainerLeadingConstraint = wrappingCollectionViewContainer.leadingAnchor.constraint(equalTo: statesContainerView.leadingAnchor, constant: defaultInset)
        wrappingCollectionViewContainerTrailingConstraint = wrappingCollectionViewContainer.trailingAnchor.constraint(equalTo: statesContainerView.trailingAnchor, constant: -defaultInset)
        
        wrappingCollectionViewLeadingConstraint = wrappingCollectionView.leadingAnchor.constraint(equalTo: wrappingCollectionViewContainer.leadingAnchor, constant: elementsContainerInset)
        wrappingCollectionViewTrailingConstraint = wrappingCollectionView.trailingAnchor.constraint(equalTo: wrappingCollectionViewContainer.trailingAnchor, constant: -elementsContainerInset)
        
        let lastVerticalConstraint = statesContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            
            helpButton.widthAnchor.constraint(equalToConstant: 20),
            helpButton.heightAnchor.constraint(equalTo: helpButton.widthAnchor),
            
            helpButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 6),
            helpButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -defaultInset),
            
            helpButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            statesContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statesContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            statesContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            holeContainerView.centerXAnchor.constraint(equalTo: statesContainerView.centerXAnchor),
            holeContainerView.topAnchor.constraint(equalTo: statesContainerView.topAnchor, constant: 20),
            
            holeLabel.leadingAnchor.constraint(equalTo: holeContainerView.leadingAnchor, constant: holeContainerInset + 1),
            holeLabel.trailingAnchor.constraint(equalTo: holeContainerView.trailingAnchor, constant: -holeContainerInset + 1),
            
            holeLabel.topAnchor.constraint(equalTo: holeContainerView.topAnchor, constant: holeContainerInset - 66),
            holeLabel.bottomAnchor.constraint(equalTo: holeContainerView.bottomAnchor, constant: -holeContainerInset + 2),
            
            addedCountLabel.centerXAnchor.constraint(equalTo: holeContainerView.centerXAnchor),
            addedCountLabel.centerYAnchor.constraint(equalTo: holeContainerView.centerYAnchor),
            
            wrappingCollectionViewContainerLeadingConstraint,
            wrappingCollectionViewContainerTrailingConstraint,
            
            wrappingCollectionViewContainer.topAnchor.constraint(equalTo: holeContainerView.bottomAnchor, constant: 12),
            
            hintLabel.leadingAnchor.constraint(equalTo: wrappingCollectionViewContainer.leadingAnchor, constant: elementsContainerInset),
            hintLabel.trailingAnchor.constraint(equalTo: wrappingCollectionViewContainer.trailingAnchor, constant: -elementsContainerInset),
            
            hintLabel.topAnchor.constraint(equalTo: wrappingCollectionViewContainer.topAnchor, constant: elementsContainerInset - 2),
            
            wrappingCollectionViewLeadingConstraint,
            wrappingCollectionViewTrailingConstraint,
            
            wrappingCollectionView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 10),
            wrappingCollectionView.bottomAnchor.constraint(equalTo: wrappingCollectionViewContainer.bottomAnchor, constant: -elementsContainerInset),
            
            resultContainer.leadingAnchor.constraint(equalTo: statesContainerView.leadingAnchor, constant: defaultInset),
            resultContainer.trailingAnchor.constraint(equalTo: statesContainerView.trailingAnchor, constant: -defaultInset),
            
            resultContainer.topAnchor.constraint(equalTo: holeContainerView.topAnchor, constant: -6),
            resultContainer.bottomAnchor.constraint(equalTo: wrappingCollectionViewContainer.bottomAnchor, constant: -10),
            
            resultNestedContainer.centerXAnchor.constraint(equalTo: resultContainer.centerXAnchor),
            resultNestedContainer.centerYAnchor.constraint(equalTo: resultContainer.centerYAnchor),
            
            resultIconLabel.leadingAnchor.constraint(equalTo: resultNestedContainer.leadingAnchor, constant: 1),
            resultIconLabel.trailingAnchor.constraint(equalTo: resultNestedContainer.trailingAnchor, constant: 1),
            
            resultIconLabel.topAnchor.constraint(equalTo: resultNestedContainer.topAnchor),
            
            resultTitleLabel.leadingAnchor.constraint(equalTo: resultNestedContainer.leadingAnchor),
            resultTitleLabel.trailingAnchor.constraint(equalTo: resultNestedContainer.trailingAnchor),
            
            resultTitleLabel.topAnchor.constraint(equalTo: resultIconLabel.bottomAnchor, constant: 4),
            resultTitleLabel.bottomAnchor.constraint(equalTo: resultNestedContainer.bottomAnchor),
            
            checkResultStackView.leadingAnchor.constraint(equalTo: statesContainerView.leadingAnchor, constant: defaultInset),
            checkResultStackView.trailingAnchor.constraint(lessThanOrEqualTo: statesContainerView.trailingAnchor, constant: -defaultInset),
            
            checkResultStackView.topAnchor.constraint(equalTo: wrappingCollectionViewContainer.bottomAnchor, constant: 16),
            checkResultStackView.bottomAnchor.constraint(equalTo: statesContainerView.bottomAnchor, constant: -defaultInset),
            
            lastVerticalConstraint
        ])
        
        var selector = #selector(helpButtonDidPress)
        helpButton.addTarget(self, action: selector, for: .touchUpInside)
        
        selector = #selector(checkResultButtonDidPress)
        checkResultButton.addTarget(self, action: selector, for: .touchUpInside)
        
        selector = #selector(resetButtonDidPress)
        resetButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var availableWidth: CGFloat?
    
    weak var delegate: InteractiveFormatViewController.ItemCell.Delegate?
    
    var model: Model? {
        didSet {
            guard let model else {
                return
            }
            
            titleLabel.text = model.title
            updateVisibleAddedCount()
            
            let localizedStrings = LocalizedStrings.Scene.ElementsMixing.AddingHint.self
            let addingHintTuple: (string: String, boldRanges: [NSRange])
            
            if model.withMultiplicity {
                addingHintTuple = localizedStrings.anyCounts
            } else {
                addingHintTuple = model.isOrderImportant ? localizedStrings.importantOrder : localizedStrings.nonImportantOrder
            }
            
            configureAddingHintLabel(text: addingHintTuple.string, boldRanges: addingHintTuple.boldRanges)
            reconfigureWrappingCollectionView()
            
            [holeContainerView, wrappingCollectionViewContainer].forEach {
                $0.alpha = 1
                $0.isHidden = model.checkResult != nil
            }
            
            resultContainer.isHidden = model.checkResult == nil
            updateVisibleResult()
            
            updateCheckResultViews(withAnimations: false)
        }
    }
    
    func checkResultIfAppropriate() {
        guard checkResultStackView.isUserInteractionEnabled, let model, model.checkResult == nil else {
            return
        }
        
        let relevantCombination = model.possibleCombinations.first {
            if model.isOrderImportant {
                return model.userMixture.hashValue == $0.components.hashValue
            } else {
                return Set(model.userMixture).hashValue == Set($0.components).hashValue
            }
        }
        
        model.checkResult = .init(relevantCombination: relevantCombination)
        updateCheckResultViews(withAnimations: true)
        
        UIView.animate(withDuration: animatingDuration, delay: 0, options: .curveEaseIn, animations: {
            self.holeContainerView.alpha = 0
            self.wrappingCollectionViewContainer.alpha = 0
        }, completion: { isFinished in
            guard isFinished else {
                return
            }
            
            self.holeContainerView.isHidden = true
            self.wrappingCollectionViewContainer.isHidden = true
            
            self.resultIconLabel.alpha = 0
            self.resultTitleLabel.alpha = 0
            
            self.updateVisibleResult()
            self.resultContainer.isHidden = false
            
            self.resultIconLabel.transform = .init(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: self.animatingDuration * 2, delay: 0, options: .curveEaseOut, animations: {
                self.resultIconLabel.alpha = 1
                self.resultIconLabel.transform = .identity
            }, completion: { isFinished in
                guard isFinished else {
                    return
                }
                
                UIView.animate(withDuration: self.animatingDuration * 2, delay: 0, options: .curveEaseOut) {
                    self.resultTitleLabel.alpha = 1
                }
                
                self.notificationFeedbackGenerator.notificationOccurred(
                    model.checkResult?.relevantCombination != nil ? .success : .error
                )
            })
        })
    }
    
    private func updateVisibleAddedCount() {
        let value = model?.userMixture.map(\.count).reduce(0, +) ?? 0
        addedCountLabel.text = value > 0 ? .init(value) : ""
    }
    
    private func configureAddingHintLabel(text: String, boldRanges: [NSRange]) {
        let fontSize: CGFloat = 13
        let textColor = UIColor.Zen.foreground.withAlphaComponent(0.5)
        
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: textColor
        ])
        
        boldRanges.forEach {
            attributedString.addAttributes([
                .font: UIFont.systemFont(ofSize: fontSize, weight: .bold),
                .foregroundColor: textColor
            ], range: $0)
        }
        
        hintLabel.attributedText = attributedString
    }
    
    private func reconfigureWrappingCollectionView() {
        guard let model else {
            return
        }
        
        var children: [(view: OptionView, size: CGSize)] = []
        
        for availableElement in model.availableElements {
            let view = OptionView {
                $0.title = availableElement
                $0.isHidden = !model.withMultiplicity && model.userMixture.contains { $0.title == availableElement }
            }
            
            var selector = #selector(someOptionViewDidPress)
            view.addTarget(self, action: selector, for: .touchUpInside)
            
            selector = #selector(panGestureDidRecognize)
            
            view.addGestureRecognizer(
                UIPanGestureRecognizer(target: self, action: selector)
            )
            
            let maxWidth = wrappingCollectionView.bounds.width - view.titleHorizontalInset * 2
            var size = view.title.calculateVisibleSize(font: view.titleFont, maxWidth: maxWidth)
            
            size.width += view.titleHorizontalInset * 2
            size.height = 28
            
            children.append(
                (view, size)
            )
        }
        
        if let availableWidth {
            wrappingCollectionView.availableWidth = availableWidth
                - wrappingCollectionViewLeadingConstraint.constant
                + wrappingCollectionViewTrailingConstraint.constant
                - wrappingCollectionViewContainerLeadingConstraint.constant
                + wrappingCollectionViewContainerTrailingConstraint.constant
        }
        
        currentOptionViews = children.map { $0.view }
        wrappingCollectionView.children = children
        
        wrappingCollectionViewHeightConstraint?.isActive = false
        wrappingCollectionView.layoutIfNeeded()
        
        wrappingCollectionViewHeightConstraint = wrappingCollectionView.heightAnchor.constraint(
            equalToConstant: wrappingCollectionView.contentSize.height
        )
        
        wrappingCollectionViewHeightConstraint?.isActive = true
    }
    
    private func updateVisibleResult() {
        guard let model else {
            return
        }
        
        if let relevantCombination = model.checkResult?.relevantCombination {
            resultIconLabel.text = model.resultIcon
            resultTitleLabel.text = relevantCombination.result
        } else {
            resultIconLabel.text = "😔"
            resultTitleLabel.text = LocalizedStrings.Scene.ElementsMixing.failure
        }
    }
    
    private func updateCheckResultViews(withAnimations: Bool) {
        guard let model else {
            return
        }
        
        let isResetButtonState = model.checkResult != nil
        let isStateChangingAnimation = withAnimations && resetButton.isHidden == isResetButtonState
        
        UIView.animate(withDuration: isStateChangingAnimation ? animatingDuration : 0, delay: 0, options: .curveEaseIn, animations: {
            if isStateChangingAnimation {
                self.checkResultStackView.alpha = 0
            }
        }, completion: { isFinished in
            guard isFinished else {
                return
            }
            
            self.checkResultStackView.isUserInteractionEnabled = !model.userMixture.isEmpty
            
            self.checkResultButton.isHidden = isResetButtonState
            self.checkResultHintLabel.isHidden = self.checkResultButton.isHidden
            
            self.resetButton.isHidden = !isResetButtonState
            
            UIView.animate(
                withDuration: withAnimations ? self.animatingDuration : 0,
                delay: isStateChangingAnimation ? (self.animatingDuration * 2) : 0,
                options: isStateChangingAnimation ? .curveEaseOut : .curveEaseInOut
            ) {
                self.checkResultStackView.alpha = self.checkResultStackView.isUserInteractionEnabled ? 1 : 0.3
            }
        })
    }
    
    private func createComplexTransform(for optionView: OptionView, translation: CGSize, fitToHole: Bool = false) -> CGAffineTransform {
        guard let superview = optionView.superview else {
            return .identity
        }
        
        var frame = superview.convert(superview.bounds, to: contentView)
        
        frame.origin.x += translation.width
        frame.origin.y += translation.height
        
        let scalingThreshold = wrappingCollectionViewContainer.convert(
            wrappingCollectionViewContainer.bounds,
            to: contentView
        ).minY
        
        var scale: CGFloat = 1
        
        if frame.maxY < scalingThreshold {
            scale = frame.maxY / scalingThreshold
            
            let minValue: CGFloat = 0.75
            scale = scale * (1 - minValue) + minValue
        }
        
        if fitToHole {
            let maxWidth = holeWidth - 32
            
            if frame.width * scale > maxWidth {
                scale = maxWidth / frame.width
            }
        }
        
        return .init(scaleX: scale, y: scale).concatenating(
            .init(translationX: translation.width, y: translation.height)
        )
    }
    
    private func handleAddingToUserMixture(with optionView: OptionView) {
        guard let model, let optionViewIndex = currentOptionViews.firstIndex(of: optionView) else {
            return
        }
        
        let correspondingElement = model.availableElements[optionViewIndex]
        
        if let componentIndex = model.userMixture.firstIndex(where: { $0.title == correspondingElement }) {
            var component = model.userMixture[componentIndex]
            component.count += 1
            
            model.userMixture[componentIndex] = component
        } else {
            let component = Model.Component(title: correspondingElement, count: 1)
            model.userMixture.append(component)
        }
        
        UIView.animate(withDuration: animatingDuration, delay: 0, options: .curveEaseIn, animations: {
            self.addedCountLabel.alpha = 0
        }, completion: { isFinished in
            guard isFinished else {
                return
            }
            
            self.updateVisibleAddedCount()
            self.updateCheckResultViews(withAnimations: true)
            
            UIView.animate(withDuration: self.animatingDuration, delay: 0, options: .curveEaseOut) {
                self.addedCountLabel.alpha = 1
            }
        })
        
        if model.withMultiplicity {
            optionView.transform = .identity
            
            UIView.animate(withDuration: animatingDuration, delay: animatingDuration) {
                optionView.alpha = 1
            }
        } else {
            optionView.isHidden = true
        }
    }
    
    @objc private func someOptionViewDidPress(_ sender: OptionView) {
        guard let superview = sender.superview else {
            return
        }
        
        selectionFeedbackGenerator.selectionChanged()
        
        let optionViewFrame = superview.convert(superview.bounds, to: contentView)
        let holeContainerViewFrame = holeContainerView.convert(holeContainerView.bounds, to: contentView)
        
        let translation = CGSize(
            width: holeContainerViewFrame.midX - optionViewFrame.midX,
            height: holeContainerViewFrame.midY - optionViewFrame.midY
        )
        
        let dropToHole = {
            UIView.animate(withDuration: self.animatingDuration, delay: 0, options: .curveEaseIn) {
                sender.transform = self.createComplexTransform(for: sender, translation: translation, fitToHole: true)
            }
            
            let duration = self.animatingDuration / 2.5
            let delay = self.animatingDuration / 3 * 2
            
            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
                sender.alpha = 0
            }, completion: { isFinished in
                guard isFinished else {
                    return
                }
                
                self.handleAddingToUserMixture(with: sender)
            })
        }
        
        guard sender.transform == .identity else {
            dropToHole()
            return
        }
        
        UIView.animate(withDuration: animatingDuration * 1.5, delay: 0, animations: {
            var translation = translation
            translation.height -= 28
            
            sender.transform = self.createComplexTransform(for: sender, translation: translation)
        }, completion: { isFinished in
            guard isFinished else {
                return
            }
            
            dropToHole()
        })
    }
    
    @objc private func panGestureDidRecognize(_ sender: UIPanGestureRecognizer) {
        guard let optionView = sender.view as? OptionView else {
            return
        }
        
        switch sender.state {
            case .changed:
                if let superview = optionView.superview, let cell = superview.superview {
                    wrappingCollectionViewContainer.superview?.bringSubviewToFront(wrappingCollectionViewContainer)
                    cell.superview?.bringSubviewToFront(cell)
                }
                
                let translation = sender.translation(in: superview)
                
                let complexTransform = createComplexTransform(
                    for: optionView,
                    translation: .init(width: translation.x, height: translation.y)
                )
                
                optionView.transform = complexTransform
                
                let frame = optionView.convert(optionView.bounds, to: contentView)
                
                if frame.minY < 0 || frame.maxY > contentView.bounds.height {
                    sender.releaseCurrentGesture()
                    optionView.transform = complexTransform
                    
                    UIView.animate(withDuration: animatingDuration) {
                        optionView.transform = .identity
                    }
                }
                
            case .ended:
                let optionViewFrame = optionView.convert(optionView.bounds, to: contentView)
                let holeContainerViewFrame = holeContainerView.convert(holeContainerView.bounds, to: contentView)
                
                let xRange = (holeContainerViewFrame.midX - holeWidth / 2) ... (holeContainerViewFrame.midX + holeWidth / 2)
                
                if xRange.contains(optionViewFrame.midX) && optionViewFrame.midY <= holeContainerViewFrame.midY {
                    self.someOptionViewDidPress(optionView)
                } else {
                    UIView.animate(withDuration: animatingDuration) {
                        optionView.transform = .identity
                    }
                }
                
            default:
                optionView.transform = .identity
        }
    }
    
    @objc private func helpButtonDidPress() {
        guard let model else {
            return
        }
        
        let localizedStrings = LocalizedStrings.Scene.ElementsMixing.HelpAlert.self
        var message = ""
        
        for possibleCombination in model.possibleCombinations {
            if !message.isEmpty {
                message += "\n\n"
            }
            
            message += possibleCombination.result
            message += ": "
            
            message += possibleCombination.components.map {
                var substring = $0.title
                
                if model.isLowercasingAllowed {
                    substring = substring.lowercased()
                }
                
                if model.withMultiplicity {
                    substring += "\u{00A0}" + localizedStrings.numberOfElements(count: $0.count)
                }
                
                return substring
            }
            .joined(separator: ", ")
            
            message += "."
        }
        
        let alertController = UIAlertController(
            title: localizedStrings.title,
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            .init(title: localizedStrings.closeButton, style: .default)
        )
        
        alertController.view.tintColor = .Zen.accent
        delegate?.presentAlertController(alertController)
    }
    
    @objc private func checkResultButtonDidPress() {
        checkResultIfAppropriate()
    }
    
    @objc private func resetButtonDidPress() {
        UIView.animate(withDuration: animatingDuration, delay: 0, options: .curveEaseIn, animations: {
            self.statesContainerView.alpha = 0
        }, completion: { isFinished in
            guard isFinished else {
                return
            }
            
            self.model?.resetState()
            self.model = nil ?? self.model
            
            UIView.animate(withDuration: self.animatingDuration, delay: 0, options: .curveEaseOut) {
                self.statesContainerView.alpha = 1
            }
        })
    }
    
}

extension ElementsMixingViewController {
    typealias ElementsMixingCell = ElementsMixingViewControllerElementsMixingCell
}

extension ElementsMixingViewController.ElementsMixingCell {
    final class Model {
        
        let title: String
        let resultIcon: String
        
        let availableElements: [String]
        let possibleCombinations: [PossibleCombination]
        
        let isOrderImportant: Bool
        let withMultiplicity: Bool
        
        let isLowercasingAllowed: Bool
        
        var userMixture: [Component] = []
        var checkResult: CheckResult?
        
        init(title: String, resultIcon: String, possibleCombinations: [PossibleCombination], isOrderImportant: Bool, isLowercasingAllowed: Bool) {
            self.title = title
            self.resultIcon = resultIcon
            
            availableElements = Set(
                possibleCombinations.flatMap {
                    $0.components.map { $0.title }
                }
            ).shuffled()
            
            self.possibleCombinations = possibleCombinations
            self.isOrderImportant = isOrderImportant
            
            withMultiplicity = possibleCombinations.contains(
                where: {
                    $0.components.contains { $0.count > 1 }
                }
            )
            
            self.isLowercasingAllowed = isLowercasingAllowed
        }
        
        func resetState() {
            userMixture = []
            checkResult = nil
        }
        
        struct Component: Hashable {
            
            let title: String
            var count: Int
            
        }
        
        struct PossibleCombination {
            
            let components: [Component]
            let result: String
            
        }
        
        struct CheckResult {
            
            let relevantCombination: PossibleCombination?
            
        }
        
    }
}
