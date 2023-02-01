//
//  SimpleTextGapsCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 16.01.2023.
//

import UIKit

final class SimpleTextGapsViewControllerSimpleTextGapsCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private let optionViewDefaultTransform = CGAffineTransform(translationX: 0, y: -3)
    
    private var currentTextOptionViews: [OptionView] = []
    private var currentInsertsOptionViews: [OptionView] = []
    
    private var currentOptionViewMatches: [OptionView: Model.Insert] = [:]
    private var maxInsertWidth: CGFloat?
    
    private let textWrappingCollectionView = WrappingCollectionView {
        $0.interitemSpacing = .init(4)
    }
    
    private let insertsWrappingCollectionViewContainer = UIView {
        $0.backgroundColor = .Zen.foreground.withAlphaComponent(0.1)
        $0.layer.cornerRadius = 12
    }
    
    private let insertsWrappingCollectionView = WrappingCollectionView {
        $0.interitemSpacing = .init(8)
    }
    
    private let resultStackView = UIStackView {
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private let checkResultButton = UIButton(type: .system).with {
        $0.setTitle(LocalizedStrings.Scene.SimpleTextGaps.checkButton, for: .normal)
        
        $0.setTitleColor(
            .Zen.accent.withAlphaComponent(0.3),
            for: .disabled
        )
    }
    
    private let resetButton = UIButton(type: .system).with {
        $0.setTitle(LocalizedStrings.Scene.SimpleTextGaps.resetButton, for: .normal)
    }
    
    private let resultIconView = UIImageView()
    
    private var textWrappingCollectionViewLeadingConstraint: NSLayoutConstraint!
    private var textWrappingCollectionViewTrailingConstraint: NSLayoutConstraint!
    
    private var insertsWrappingCollectionViewContainerLeadingConstraint: NSLayoutConstraint!
    private var insertsWrappingCollectionViewContainerTrailingConstraint: NSLayoutConstraint!
    
    private var insertsWrappingCollectionViewLeadingConstraint: NSLayoutConstraint!
    private var insertsWrappingCollectionViewTrailingConstraint: NSLayoutConstraint!
    
    private var textWrappingCollectionViewHeightConstraint: NSLayoutConstraint?
    private var insertsWrappingCollectionViewHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            textWrappingCollectionView,
            
            insertsWrappingCollectionViewContainer.addSubviews(
                insertsWrappingCollectionView
            ),
            
            resultStackView.addArrangedSubviews(
                checkResultButton,
                resultIconView
            ),
            
            resetButton
        )
        
        let defaultInset: CGFloat = 20
        let insertsContainerInset: CGFloat = 12
        
        textWrappingCollectionViewLeadingConstraint = textWrappingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset)
        textWrappingCollectionViewTrailingConstraint = textWrappingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset)
        
        insertsWrappingCollectionViewContainerLeadingConstraint = insertsWrappingCollectionViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset)
        insertsWrappingCollectionViewContainerTrailingConstraint = insertsWrappingCollectionViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset)
        
        insertsWrappingCollectionViewLeadingConstraint = insertsWrappingCollectionView.leadingAnchor.constraint(equalTo: insertsWrappingCollectionViewContainer.leadingAnchor, constant: insertsContainerInset)
        insertsWrappingCollectionViewTrailingConstraint = insertsWrappingCollectionView.trailingAnchor.constraint(equalTo: insertsWrappingCollectionViewContainer.trailingAnchor, constant: -insertsContainerInset)
        
        let lastVerticalConstraint = resultStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            textWrappingCollectionViewLeadingConstraint!,
            textWrappingCollectionViewTrailingConstraint!,
            
            textWrappingCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultInset + 8),
            
            insertsWrappingCollectionViewContainerLeadingConstraint,
            insertsWrappingCollectionViewContainerTrailingConstraint,
            
            insertsWrappingCollectionViewContainer.topAnchor.constraint(equalTo: textWrappingCollectionView.bottomAnchor, constant: 16),
            
            insertsWrappingCollectionViewLeadingConstraint!,
            insertsWrappingCollectionViewTrailingConstraint!,
            
            insertsWrappingCollectionView.topAnchor.constraint(equalTo: insertsWrappingCollectionViewContainer.topAnchor, constant: insertsContainerInset - optionViewDefaultTransform.ty),
            insertsWrappingCollectionView.bottomAnchor.constraint(equalTo: insertsWrappingCollectionViewContainer.bottomAnchor, constant: -insertsContainerInset - optionViewDefaultTransform.ty),
            
            resultStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            resultStackView.topAnchor.constraint(equalTo: insertsWrappingCollectionViewContainer.bottomAnchor, constant: 12),
            
            resetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            resetButton.centerYAnchor.constraint(equalTo: checkResultButton.centerYAnchor),
            
            lastVerticalConstraint
        ])
        
        var selector = #selector(checkResultButtonDidPress)
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
            guard let model, let availableWidth else {
                return
            }
            
            var maxInsertWidth = availableWidth
                - insertsWrappingCollectionViewLeadingConstraint.constant
                + insertsWrappingCollectionViewTrailingConstraint.constant
                - insertsWrappingCollectionViewContainerLeadingConstraint.constant
                + insertsWrappingCollectionViewContainerTrailingConstraint.constant
                - OptionView.titleHorizontalInset * 2
            
            maxInsertWidth = model.orderedInserts
                .map { $0.title.calculateVisibleSize(font: OptionView.titleFont, maxWidth: maxInsertWidth).width }
                .max() ?? 0
            
            maxInsertWidth += OptionView.titleHorizontalInset * 2
            self.maxInsertWidth = maxInsertWidth
            
            reconfigureWrappingCollectionViews()
            
            updateCheckResultButton()
            resetButton.isHidden = model.checkResult == nil
            
            updateVisibleResult()
        }
    }
    
    private func reconfigureWrappingCollectionViews() {
        currentOptionViewMatches = [:]
        
        reconfigureTextWrappingCollectionView()
        reconfigureInsertsWrappingCollectionView()
    }
    
    private func reconfigureTextWrappingCollectionView() {
        guard let model else {
            return
        }
        
        currentTextOptionViews = []
        
        let templateComponents = model.template.split(by: "%@").map({
            $0.split(separator: " ").map { String($0) }
        }).flatMap { $0 }
        
        var children: [(view: UIView, size: CGSize)] = []
        
        for templateComponent in templateComponents {
            if templateComponent != "%@" {
                let templateComponent = templateComponent.trimmingCharacters(in: .whitespaces)
                
                let view = UILabel {
                    $0.text = templateComponent
                }
                
                let size = templateComponent.calculateVisibleSize(font: view.font, maxWidth: textWrappingCollectionView.bounds.width)
                
                children.append(
                    (view, size)
                )
            } else {
                let gapIndex = currentTextOptionViews.count
                let insert = model.orderedInserts[gapIndex]
                
                let tuple = createOptionView(insert, for: textWrappingCollectionView)
                let isEmpty = !model.userInput.keys.contains(insert)
                
                tuple.view.isTemplate = isEmpty
                tuple.view.isUserInteractionEnabled = isEmpty
                
                children.append(tuple)
                currentTextOptionViews.append(tuple.view)
            }
        }
        
        if let availableWidth {
            textWrappingCollectionView.availableWidth = availableWidth
                - textWrappingCollectionViewLeadingConstraint.constant
                + textWrappingCollectionViewTrailingConstraint.constant
        }
        
        textWrappingCollectionView.children = children
        
        textWrappingCollectionViewHeightConstraint?.isActive = false
        textWrappingCollectionView.layoutIfNeeded()
        
        textWrappingCollectionViewHeightConstraint = textWrappingCollectionView.heightAnchor.constraint(
            equalToConstant: textWrappingCollectionView.contentSize.height
        )
        
        textWrappingCollectionViewHeightConstraint?.isActive = true
    }
    
    private func reconfigureInsertsWrappingCollectionView() {
        guard let model else {
            return
        }
        
        var children: [(view: UIView, size: CGSize)] = []
        currentInsertsOptionViews = []
        
        for insert in model.shuffledInserts {
            let tuple = createOptionView(insert, for: insertsWrappingCollectionView)
            tuple.view.isHidden = model.userInput.values.contains(insert)
            
            children.append(tuple)
            currentInsertsOptionViews.append(tuple.view)
        }
        
        if let availableWidth {
            insertsWrappingCollectionView.availableWidth = availableWidth
                - insertsWrappingCollectionViewLeadingConstraint.constant
                + insertsWrappingCollectionViewTrailingConstraint.constant
                - insertsWrappingCollectionViewContainerLeadingConstraint.constant
                + insertsWrappingCollectionViewContainerTrailingConstraint.constant
        }
        
        insertsWrappingCollectionView.children = children
        
        insertsWrappingCollectionViewHeightConstraint?.isActive = false
        insertsWrappingCollectionView.layoutIfNeeded()
        
        insertsWrappingCollectionViewHeightConstraint = insertsWrappingCollectionView.heightAnchor.constraint(
            equalToConstant: insertsWrappingCollectionView.contentSize.height
        )
        
        insertsWrappingCollectionViewHeightConstraint?.isActive = true
    }
    
    private func createOptionView(_ insert: Model.Insert, for container: WrappingCollectionView) -> (view: OptionView, size: CGSize) {
        let optionView = OptionView {
            $0.title = model?.userInput[insert]?.title ?? insert.title
            $0.isSelected = insert == model?.selectedInsert
            
            $0.transform = optionViewDefaultTransform
        }
        
        var selector = #selector(someOptionViewDidPress)
        optionView.addTarget(self, action: selector, for: .touchUpInside)
        
        if container == insertsWrappingCollectionView {
            selector = #selector(panGestureDidRecognize)
            
            optionView.addGestureRecognizer(
                UIPanGestureRecognizer(target: self, action: selector)
            )
        }
        
        currentOptionViewMatches[optionView] = insert
        
        return (
            optionView,
            CGSize(width: maxInsertWidth ?? 0, height: 28)
        )
    }
    
    private func updateVisibleSelection() {
        currentOptionViewMatches.forEach {
            $0.key.isSelected = $0.value == model?.selectedInsert
        }
    }
    
    private func updateCheckResultButton() {
        guard let model else {
            return
        }
        
        checkResultButton.isEnabled = model.userInput.count == model.shuffledInserts.count
    }
    
    private func updateVisibleResult() {
        if let actualCheckResult = model?.checkResult {
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
    
    @objc private func someOptionViewDidPress(_ sender: OptionView) {
        let firstView = sender
        
        guard let model, let firstInsert = currentOptionViewMatches[sender], !model.userInput.keys.contains(firstInsert) else {
            return
        }
        
        if let secondInsert = model.selectedInsert {
            guard
                firstInsert != secondInsert,
                let secondView = currentOptionViewMatches.first(where: { $0.value == secondInsert })?.key
            else {
                return
            }
            
            if [currentTextOptionViews, currentInsertsOptionViews].contains(where: { $0.contains(firstView) && $0.contains(secondView) }) {
                model.selectedInsert = firstInsert
            } else {
                var firstView = firstView
                var secondView = secondView
                
                var firstInsert = firstInsert
                var secondInsert = secondInsert
                
                if currentTextOptionViews.contains(secondView) || currentInsertsOptionViews.contains(firstView) {
                    (firstInsert, secondInsert) = (secondInsert, firstInsert)
                    (firstView, secondView) = (secondView, firstView)
                }
                
                model.userInput[firstInsert] = secondInsert
                model.selectedInsert = nil
                
                reconfigureWrappingCollectionViews()
                updateCheckResultButton()
            }
        } else {
            model.selectedInsert = firstInsert
        }
        
        updateVisibleSelection()
    }
    
    @objc private func panGestureDidRecognize(_ sender: UIPanGestureRecognizer) {
        guard let optionView = sender.view as? OptionView, let model else {
            return
        }
        
        let defaultTransform = optionViewDefaultTransform
        let animatingDuration: TimeInterval = 0.25
        
        switch sender.state {
            case .began:
                model.selectedInsert = currentOptionViewMatches[optionView]
                updateVisibleSelection()
                
            case .changed:
                if let contentView = optionView.superview, let cell = contentView.superview {
                    insertsWrappingCollectionViewContainer.superview?.bringSubviewToFront(insertsWrappingCollectionViewContainer)
                    cell.superview?.bringSubviewToFront(cell)
                }
                
                var translation = sender.translation(in: optionView)
                
                translation.x += defaultTransform.tx
                translation.y += defaultTransform.ty
                
                optionView.transform = .init(translationX: translation.x, y: translation.y)
                
                let frame = optionView.convert(optionView.bounds, to: contentView)
                
                if frame.minY < 0 || frame.maxY > contentView.bounds.height {
                    sender.releaseCurrentGesture()
                    optionView.transform = .init(translationX: translation.x, y: translation.y)
                    
                    UIView.animate(withDuration: animatingDuration) {
                        optionView.transform = defaultTransform
                    }
                }
                
            case .ended:
                var correspondingOptionView: OptionView?
                
                for anotherOptionView in currentTextOptionViews {
                    let point = sender.location(in: anotherOptionView)
                    
                    if anotherOptionView.bounds.contains(point) {
                        correspondingOptionView = anotherOptionView
                        break
                    }
                }
                
                let duration: TimeInterval = correspondingOptionView == nil ? animatingDuration : 0
                
                UIView.animate(withDuration: duration) {
                    optionView.transform = defaultTransform
                }
                
                if let correspondingOptionView {
                    someOptionViewDidPress(correspondingOptionView)
                }
                
            default:
                optionView.transform = defaultTransform
        }
    }
    
    @objc private func checkResultButtonDidPress() {
        guard let model else {
            return
        }
        
        model.checkResult =
            model.userInput.count == model.shuffledInserts.count &&
            model.userInput.allSatisfy { $0.key.title == $0.value.title }
        
        resetButton.isHidden = false
        updateCheckResultButton()
        
        updateVisibleResult()
    }
    
    @objc private func resetButtonDidPress() {
        model?.resetState()
        model = nil ?? model
    }
    
}

extension SimpleTextGapsViewController {
    typealias SimpleTextGapsCell = SimpleTextGapsViewControllerSimpleTextGapsCell
}

extension SimpleTextGapsViewController.SimpleTextGapsCell {
    final class Model {
        
        let template: String
        let orderedInserts: [Insert]
        
        private(set) lazy var shuffledInserts = orderedInserts
            .map { Insert(title: $0.title) }
            .shuffled()
        
        var selectedInsert: Insert?
        
        var userInput: [Insert: Insert] = [:]
        var checkResult: Bool?
        
        init(template: String, inserts: [Insert]) {
            self.template = template
            self.orderedInserts = inserts
        }
        
        func resetState() {
            selectedInsert = nil
            
            userInput = [:]
            checkResult = nil
        }
        
        final class Insert: Hashable {
            
            typealias Insert = SimpleTextGapsViewControllerSimpleTextGapsCell.Model.Insert
            
            let title: String
            
            private let id = UUID().uuidString
            
            init(title: String) {
                self.title = title
            }
            
            static func == (lhs: Insert, rhs: Insert) -> Bool {
                return lhs.id == rhs.id
            }
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(id)
            }
            
        }
        
    }
}
