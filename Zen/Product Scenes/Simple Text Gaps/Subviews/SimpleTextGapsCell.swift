//
//  SimpleTextGapsCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 16.01.2023.
//

import UIKit

final class SimpleTextGapsViewControllerSimpleTextGapsCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private let optionViewDefaultTransform = CGAffineTransform(translationX: 0, y: -4)
    
    private var currentTextOptionViews: [OptionView] = []
    private var currentInsertsOptionViews: [OptionView] = []
    
    private let textWrappingCollectionView = WrappingCollectionView {
        $0.interitemSpacing = .init(4)
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
        
        let titleColor = UIColor.Zen.accent
        $0.setTitleColor(titleColor, for: .normal)
        
        $0.setTitleColor(
            titleColor.withAlphaComponent(0.3),
            for: .disabled
        )
    }
    
    private let resultIconView = UIImageView()
    
    private var textWrappingCollectionViewLeadingConstraint: NSLayoutConstraint!
    private var textWrappingCollectionViewTrailingConstraint: NSLayoutConstraint!
    
    private var insertsWrappingCollectionViewLeadingConstraint: NSLayoutConstraint!
    private var insertsWrappingCollectionViewTrailingConstraint: NSLayoutConstraint!
    
    private var textWrappingCollectionViewHeightConstraint: NSLayoutConstraint?
    private var insertsWrappingCollectionViewHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            textWrappingCollectionView,
            insertsWrappingCollectionView,
            
            resultStackView.addArrangedSubviews(
                checkResultButton,
                resultIconView
            )
        )
        
        let defaultInset: CGFloat = 20
        
        textWrappingCollectionViewLeadingConstraint = textWrappingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset)
        textWrappingCollectionViewTrailingConstraint = textWrappingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset)
        
        insertsWrappingCollectionViewLeadingConstraint = insertsWrappingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset)
        insertsWrappingCollectionViewTrailingConstraint = insertsWrappingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset)
        
        let lastVerticalConstraint = resultStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            textWrappingCollectionViewLeadingConstraint!,
            textWrappingCollectionViewTrailingConstraint!,
            
            textWrappingCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultInset + 8),
            
            insertsWrappingCollectionViewLeadingConstraint!,
            insertsWrappingCollectionViewTrailingConstraint!,
            
            insertsWrappingCollectionView.topAnchor.constraint(equalTo: textWrappingCollectionView.bottomAnchor, constant: 24),
            
            resultStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            resultStackView.topAnchor.constraint(equalTo: insertsWrappingCollectionView.bottomAnchor, constant: 4),
            
            lastVerticalConstraint
        ])
        
        let selector = #selector(checkResultButtonDidPress)
        checkResultButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var availableWidth: CGFloat?
    
    var model: Model? {
        didSet {
            reconfigureTextWrappingCollectionView()
            reconfigureInsertsWrappingCollectionView()
            
            updateCheckResultButton()
            updateVisibleResult()
        }
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
                
                let tuple = createOptionView(for: insert, for: textWrappingCollectionView)
                tuple.view.isTemplate = true
                
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
            let tuple = createOptionView(for: insert, for: insertsWrappingCollectionView)
            
            children.append(tuple)
            currentInsertsOptionViews.append(tuple.view)
        }
        
        if let availableWidth {
            insertsWrappingCollectionView.availableWidth = availableWidth
                - insertsWrappingCollectionViewLeadingConstraint.constant
                + insertsWrappingCollectionViewTrailingConstraint.constant
        }
        
        insertsWrappingCollectionView.children = children
        
        insertsWrappingCollectionViewHeightConstraint?.isActive = false
        insertsWrappingCollectionView.layoutIfNeeded()
        
        insertsWrappingCollectionViewHeightConstraint = insertsWrappingCollectionView.heightAnchor.constraint(
            equalToConstant: insertsWrappingCollectionView.contentSize.height
        )
        
        insertsWrappingCollectionViewHeightConstraint?.isActive = true
    }
    
    private func createOptionView(for insert: Model.Insert, for container: WrappingCollectionView) -> (view: OptionView, size: CGSize) {
        let optionView = OptionView {
            $0.title = insert.title
            $0.isSelected = insert === model?.selectedInsert
            
            $0.transform = optionViewDefaultTransform
        }
        
        var size = insert.title.calculateVisibleSize(font: optionView.titleFont, maxWidth: container.bounds.width)
        
        size.width += 16
        size.height = 28
        
        var selector = #selector(someOptionViewDidPress)
        optionView.addTarget(self, action: selector, for: .touchUpInside)
        
        if container == insertsWrappingCollectionView {
            selector = #selector(panGestureDidRecognize)
            
            optionView.addGestureRecognizer(
                UIPanGestureRecognizer(target: self, action: selector)
            )
        }
        
        return (optionView, size)
    }
    
    private func updateVisibleSelection(selectedView: OptionView) {
        (currentTextOptionViews + currentInsertsOptionViews).forEach {
            $0.isSelected = $0 == selectedView
        }
    }
    
    private func updateCheckResultButton() {
        guard let model else {
            return
        }
        
        checkResultButton.isEnabled = model.userState.count == model.shuffledInserts.count
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
    
    @objc private func someOptionViewDidPress(_ sender: OptionView) {
        guard let model else {
            return
        }
        
        var insert: Model.Insert?
        
        if let index = currentTextOptionViews.firstIndex(of: sender) {
            insert = model.orderedInserts[index]
        } else {
            if let index = currentInsertsOptionViews.firstIndex(of: sender) {
                insert = model.shuffledInserts[index]
            }
        }
        
        model.selectedInsert = insert
        updateVisibleSelection(selectedView: sender)
    }
    
    @objc private func panGestureDidRecognize(_ sender: UIPanGestureRecognizer) {
        guard let optionView = sender.view as? OptionView, let model else {
            return
        }
        
        let defaultTransform = optionViewDefaultTransform
        let animatingDuration: TimeInterval = 0.25
        
        switch sender.state {
            case .began:
                if let index = currentInsertsOptionViews.firstIndex(of: optionView) {
                    model.selectedInsert = model.shuffledInserts[index]
                    updateVisibleSelection(selectedView: optionView)
                }
                
            case .changed:
                if let contentView = optionView.superview, let cell = contentView.superview {
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
                
                optionView.transform = defaultTransform
                
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
        
        model.actualCheckResult =
            model.userState.count == model.shuffledInserts.count &&
            model.userState.allSatisfy { model.orderedInserts[$0.key].title == model.shuffledInserts[$0.value].title }
        
        updateVisibleResult()
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
        
        var userState: [Int: Int] = [:]
        var actualCheckResult: Bool?
        
        init(template: String, inserts: [Insert]) {
            self.template = template
            self.orderedInserts = inserts
        }
        
        final class Insert {
            
            let title: String
            
            init(title: String) {
                self.title = title
            }
            
        }
        
    }
}
