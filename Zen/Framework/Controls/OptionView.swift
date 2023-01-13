//
//  OptionView.swift
//  Zen
//
//  Created by Sergey Moskvin on 12.01.2023.
//

import UIKit

final class OptionView: UIView {
    
    private let titleLabel = UILabel {
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .Zen.background
        
        layer.borderColor = UIColor.Zen.foreground.cgColor
        layer.borderWidth = 1.5
        
        layer.cornerRadius = 16
        
        addSubviews(
            titleLabel
        )
        
        let inset: CGFloat = 12
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String {
        get {
            return titleLabel.text ?? ""
        } set {
            titleLabel.text = newValue
        }
    }
    
}
