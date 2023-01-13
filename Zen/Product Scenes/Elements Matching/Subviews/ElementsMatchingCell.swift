//
//  ElementsMatchingCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 12.01.2023.
//

import UIKit

final class ElementsMatchingViewControllerElementsMatchingCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private let titleLabel = UILabel {
        $0.font = .systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
        $0.numberOfLines = 0
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            titleLabel,
            primaryStackView,
            secondaryStackView
        )
        
        let defaultInset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            primaryStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            primaryStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultInset),
            
            secondaryStackView.topAnchor.constraint(equalTo: primaryStackView.topAnchor),
            secondaryStackView.bottomAnchor.constraint(equalTo: primaryStackView.bottomAnchor),
            
            primaryStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            secondaryStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.title
        
        primaryStackView.removeArrangedSubviews()
        secondaryStackView.removeArrangedSubviews()
        
        model.primaryElements.forEach { title in
            let optionView = OptionView {
                $0.title = title
            }
            
            primaryStackView.addArrangedSubview(optionView)
        }
        
        model.secondaryElements.forEach { title in
            let optionView = OptionView {
                $0.title = title
            }
            
            secondaryStackView.addArrangedSubview(optionView)
        }
    }
    
}

extension ElementsMatchingViewController {
    typealias ElementsMatchingCell = ElementsMatchingViewControllerElementsMatchingCell
}

extension ElementsMatchingViewController.ElementsMatchingCell {
    final class Model {
        
        let title: String
        let pairs: [(String, String)]
        
        private(set) lazy var primaryElements = pairs.map({ $0.0 }).shuffled()
        private(set) lazy var secondaryElements = pairs.map({ $0.1 }).shuffled()
        
        init(title: String, pairs: [(String, String)]) {
            self.title = title
            self.pairs = pairs
        }
        
    }
}
