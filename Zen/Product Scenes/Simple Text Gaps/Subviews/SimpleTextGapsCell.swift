//
//  SimpleTextGapsCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 16.01.2023.
//

import UIKit

final class SimpleTextGapsViewControllerSimpleTextGapsCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private var currentTextOptionsView: [OptionView] = []
    private var currentInsertsOptionsView: [OptionView] = []
    
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
        
        let lastVerticalConstraint = resultStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            textWrappingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            textWrappingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            textWrappingCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultInset),
            
            insertsWrappingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            insertsWrappingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            insertsWrappingCollectionView.topAnchor.constraint(equalTo: textWrappingCollectionView.bottomAnchor, constant: 18),
            
            resultStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            resultStackView.topAnchor.constraint(equalTo: insertsWrappingCollectionView.bottomAnchor, constant: 14),
            
            lastVerticalConstraint
        ])
        
        let selector = #selector(checkResultButtonDidPress)
        checkResultButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        currentTextOptionsView = []
        
        let templateComponents = model.template.split(by: "%@").map({
            $0.split(separator: " ").map { String($0) }
        }).flatMap { $0 }
        
        var children: [(view: UIView, size: CGSize)] = []
        
        for templateComponent in templateComponents {
            if templateComponent != "%@" {
                let view = UILabel {
                    $0.text = templateComponent
                }
                
                let size = templateComponent.calculateVisibleSize(font: view.font, maxWidth: textWrappingCollectionView.bounds.width)
                
                children.append(
                    (view, size)
                )
            } else {
                let gapIndex = currentTextOptionsView.count
                let insert = model.orderedInserts[gapIndex]
                
                let tuple = createOptionView(title: insert, for: textWrappingCollectionView)
                tuple.view.isTemplate = true
                
                children.append(tuple)
                currentTextOptionsView.append(tuple.view)
            }
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
        currentInsertsOptionsView = []
        
        for insert in model.shuffledInserts {
            let tuple = createOptionView(title: insert, for: insertsWrappingCollectionView)
            
            children.append(tuple)
            currentTextOptionsView.append(tuple.view)
        }
        
        insertsWrappingCollectionView.children = children
        
        insertsWrappingCollectionViewHeightConstraint?.isActive = false
        insertsWrappingCollectionView.layoutIfNeeded()
        
        insertsWrappingCollectionViewHeightConstraint = insertsWrappingCollectionView.heightAnchor.constraint(
            equalToConstant: insertsWrappingCollectionView.contentSize.height
        )
        
        insertsWrappingCollectionViewHeightConstraint?.isActive = true
    }
    
    private func createOptionView(title: String, for container: WrappingCollectionView) -> (view: OptionView, size: CGSize) {
        let optionView = OptionView {
            $0.title = title
            $0.transform = .init(translationX: 0, y: -4)
        }
        
        var size = title.calculateVisibleSize(font: optionView.titleFont, maxWidth: container.bounds.width)
        
        size.width += 16
        size.height = 28
        
        return (optionView, size)
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
    
    @objc private func checkResultButtonDidPress() {
        guard let model else {
            return
        }
        
        model.actualCheckResult =
            model.userState.count == model.shuffledInserts.count &&
            model.userState.allSatisfy { model.orderedInserts[$0.key] == model.shuffledInserts[$0.value] }
        
        updateVisibleResult()
    }
    
}

extension SimpleTextGapsViewController {
    typealias SimpleTextGapsCell = SimpleTextGapsViewControllerSimpleTextGapsCell
}

extension SimpleTextGapsViewController.SimpleTextGapsCell {
    final class Model {
        
        let template: String
        let orderedInserts: [String]
        
        private(set) lazy var shuffledInserts = orderedInserts.shuffled()
        
        var userState: [Int: Int] = [:]
        var actualCheckResult: Bool?
        
        init(template: String, inserts: [String]) {
            self.template = template
            self.orderedInserts = inserts
        }
        
    }
}
