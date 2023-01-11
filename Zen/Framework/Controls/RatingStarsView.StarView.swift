//
//  RatingStarsView.StarView.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

extension RatingStarsView {
    final class StarView: UIView {
        
        private let image = UIImage(systemName: "star.fill")
        
        private lazy var backgroundImageView = UIImageView {
            $0.image = image
            $0.tintColor = .secondaryLabel
        }
        
        private lazy var foregroundImageView = UIImageView {
            $0.image = image
            $0.tintColor = .Zen.accent
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubviews(
                backgroundImageView,
                foregroundImageView
            )
            
            NSLayoutConstraint.activate(
                [backgroundImageView, foregroundImageView].flatMap {
                    return [
                        $0.leadingAnchor.constraint(equalTo: leadingAnchor),
                        $0.trailingAnchor.constraint(equalTo: trailingAnchor),
                        $0.topAnchor.constraint(equalTo: topAnchor),
                        $0.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ]
                }
            )
        }
        
        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        var intermediateScore: Double = 0 {
            didSet {
                updateImageViews()
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            updateMasks()
        }
        
        private func updateImageViews() {
            backgroundImageView.isHidden = intermediateScore >= 1
            foregroundImageView.isHidden = intermediateScore <= 0
            
            updateMasks()
        }
        
        private func updateMasks() {
            guard intermediateScore > 0, intermediateScore < 1 else {
                backgroundImageView.layer.mask = nil
                foregroundImageView.layer.mask = nil
                
                return
            }
            
            backgroundImageView.layer.mask = createMask(
                withSize: backgroundImageView.bounds.size,
                fillingMultiplier: intermediateScore,
                inversed: true
            )
            
            foregroundImageView.layer.mask = createMask(
                withSize: foregroundImageView.bounds.size,
                fillingMultiplier: intermediateScore,
                inversed: false
            )
        }
        
        private func createMask(withSize size: CGSize, fillingMultiplier: CGFloat, inversed: Bool) -> CAShapeLayer {
            var x: CGFloat = 0
            var width = size.width * fillingMultiplier
            
            if inversed {
                x = width
                width = size.width - x
            }
            
            let rect = CGRect(
                origin: .init(x: x, y: 0),
                size: .init(width: width, height: size.height)
            )
            
            let mask = CAShapeLayer()
            mask.path = .init(rect: rect, transform: nil)
            return mask
        }
        
    }
}
