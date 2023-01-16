//
//  EditableTextGapsCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

final class EditableTextGapsViewControllerEditableTextGapsCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private var currentTextFields: [UITextField] = []
    
    private let wrappingCollectionView = WrappingCollectionView()
    
    private let resultStackView = UIStackView {
        $0.alignment = .center
        $0.spacing = 8
    }
    
    private let checkResultButton = UIButton(type: .system).with {
        $0.setTitle(LocalizedStrings.Scene.EditableTextGaps.checkButton, for: .normal)
        
        let titleColor = UIColor.Zen.accent
        $0.setTitleColor(titleColor, for: .normal)
        
        $0.setTitleColor(
            titleColor.withAlphaComponent(0.3),
            for: .disabled
        )
    }
    
    private let resultIconView = UIImageView()
    
    private var wrappingCollectionViewHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            wrappingCollectionView,
            
            resultStackView.addArrangedSubviews(
                checkResultButton,
                resultIconView
            )
        )
        
        let defaultInset: CGFloat = 20
        
        let lastVerticalConstraint = resultStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            wrappingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            wrappingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            wrappingCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultInset),
            
            resultStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            resultStackView.topAnchor.constraint(equalTo: wrappingCollectionView.bottomAnchor, constant: 14),
            
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
            reconfigureWrappingCollectionView()
            
            updateCheckResultButton()
            updateVisibleResult()
        }
    }
    
    private func reconfigureWrappingCollectionView() {
        guard let model else {
            return
        }
        
        currentTextFields = []
        
        let templateComponents = model.template.split(by: "%@").map({
            $0.split(separator: " ").map { String($0) }
        }).flatMap { $0 }
        
        var children: [(view: UIView, size: CGSize)] = []
        
        for templateComponent in templateComponents {
            if templateComponent != "%@" {
                let view = UILabel {
                    $0.text = templateComponent
                }
                
                let size = templateComponent.calculateVisibleSize(font: view.font, maxWidth: wrappingCollectionView.bounds.width)
                
                children.append(
                    (view, size)
                )
            } else {
                let gapIndex = currentTextFields.count
                
                let view = TextField {
                    $0.transform = .init(translationX: 0, y: -4)
                }
                
                view.text = model.userInput[gapIndex]
                view.returnKeyType = gapIndex < model.inserts.count - 1 ? .next : .done
                
                let insert = model.inserts[gapIndex]
                view.maxTextLength = insert.count
                
                view.returnKeyPressHandler = { [weak self] in
                    guard let self = self else {
                        return
                    }
                    
                    if view.returnKeyType == .next {
                        self.currentTextFields[gapIndex + 1].becomeFirstResponder()
                    } else {
                        view.endEditing(true)
                        
                        if self.checkResultButton.isEnabled {
                            self.checkResultButtonDidPress()
                        }
                    }
                }
                
                let selector = #selector(someTextFieldValueDidChange)
                view.addTarget(self, action: selector, for: .editingChanged)
                
                if let font = view.font {
                    var size = insert.calculateVisibleSize(font: font, maxWidth: wrappingCollectionView.bounds.width)
                    
                    size.width += 16
                    size.height = 28
                    
                    children.append(
                        (view, size)
                    )
                }
                
                currentTextFields.append(view)
            }
        }
        
        wrappingCollectionView.children = children
        
        wrappingCollectionViewHeightConstraint?.isActive = false
        wrappingCollectionView.layoutIfNeeded()
        
        wrappingCollectionViewHeightConstraint = wrappingCollectionView.heightAnchor.constraint(
            equalToConstant: wrappingCollectionView.contentSize.height
        )
        
        wrappingCollectionViewHeightConstraint?.isActive = true
    }
    
    private func updateCheckResultButton() {
        guard let model else {
            return
        }
        
        checkResultButton.isEnabled = model.userInput.count == model.inserts.count && model.userInput.values.allSatisfy { !$0.isEmpty }
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
    
    @objc private func someTextFieldValueDidChange(_ sender: TextField) {
        guard let model, let index = currentTextFields.firstIndex(of: sender) else {
            return
        }
        
        model.userInput[index] = sender.text ?? ""
        model.actualCheckResult = nil
        
        updateCheckResultButton()
        updateVisibleResult()
    }
    
    @objc private func checkResultButtonDidPress() {
        guard let model else {
            return
        }
        
        model.actualCheckResult = model.userInput.count == model.inserts.count
        
        if model.actualCheckResult == true {
            for (index, insert) in model.inserts.enumerated() {
                if model.userInput[index] != insert {
                    model.actualCheckResult = false
                    break
                }
            }
        }
        
        updateVisibleResult()
    }
    
}

extension EditableTextGapsViewController {
    typealias EditableTextGapsCell = EditableTextGapsViewControllerEditableTextGapsCell
}

extension EditableTextGapsViewController.EditableTextGapsCell {
    final class Model {
        
        let template: String
        let inserts: [String]
        
        var userInput: [Int: String] = [:]
        var actualCheckResult: Bool?
        
        init(template: String, inserts: [String]) {
            self.template = template
            self.inserts = inserts
        }
        
    }
}
