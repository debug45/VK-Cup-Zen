//
//  RatingStarsView.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

final class RatingStarsView: UIControl {
    
    private let stackView = UIStackView {
        $0.spacing = 2
    }
    
    private lazy var starViews = (1 ... 5).map { _ in
        StarView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(
            stackView.addArrangedSubviews(starViews)
        )
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let selector = #selector(someGestureDidRecognize)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: selector)
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
    
    var rating: Double = 0 {
        didSet {
            reconfigureStars()
        }
    }
    
    var ratingChangeHandler: ((Double) -> Void)?
    
    private func reconfigureStars() {
        var intermediateScore = rating
        
        starViews.forEach {
            $0.intermediateScore = intermediateScore
            intermediateScore -= 1
        }
    }
    
    @objc private func someGestureDidRecognize(_ sender: UIGestureRecognizer) {
        let point = sender.location(in: stackView)
        
        for (index, view) in starViews.enumerated() {
            guard view.frame.contains(point) else {
                continue
            }
            
            rating = Double(index + 1)
            
            if sender is UIPanGestureRecognizer {
                let point = stackView.convert(point, to: view)
                rating += point.x / view.bounds.width - 1
            }
            
            ratingChangeHandler?(rating)
            break
        }
    }
    
}
