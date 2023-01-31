//
//  FooterView.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension MainViewController {
    final class FooterView: UIView {
        
        private let contentLabel = UILabel {
            $0.font = .systemFont(ofSize: 14)
            $0.numberOfLines = 0
            $0.text = LocalizedStrings.Scene.Main.footer
            $0.textColor = .Zen.foreground.withAlphaComponent(0.5)
            $0.textAlignment = .center
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubviews(
                contentLabel
            )
            
            let defaultInset: CGFloat = 20
            
            NSLayoutConstraint.activate([
                contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultInset),
                contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultInset),
                
                contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: defaultInset + 32),
                contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -defaultInset)
            ])
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
}
