//
//  RatingStarsCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

final class RatingStarsViewControllerRatingStarsCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private static let scoreFormatter = NumberFormatter {
        $0.maximumFractionDigits = 1
    }
    
    private let titleLabel = UILabel {
        $0.numberOfLines = 0
        $0.textColor = .Zen.foreground
    }
    
    private lazy var ratingStarsView = RatingStarsView {
        $0.ratingChangeHandler = { [weak self] newValue in
            self?.handleUserScore(newValue)
        }
    }
    
    private let scoreLabel = UILabel {
        $0.alpha = 0.5
        $0.textColor = .Zen.foreground
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            titleLabel,
            ratingStarsView,
            scoreLabel
        )
        
        let defaultInset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            ratingStarsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            ratingStarsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            ratingStarsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset - 2),
            
            scoreLabel.leadingAnchor.constraint(equalTo: ratingStarsView.trailingAnchor, constant: 16),
            scoreLabel.centerYAnchor.constraint(equalTo: ratingStarsView.centerYAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: Model? {
        didSet {
            guard let model else {
                return
            }
            
            titleLabel.text = model.title
            ratingStarsView.rating = model.score ?? 0
            
            updateScoreLabel()
        }
    }
    
    private func updateScoreLabel() {
        let string = Self.scoreFormatter.string(
            from: .init(value: model?.score ?? 0)
        )
        
        scoreLabel.text = string != "0" ? string : nil
    }
    
    private func handleUserScore(_ value: Double) {
        model?.score = value
        updateScoreLabel()
    }
    
}

extension RatingStarsViewController {
    typealias RatingStarsCell = RatingStarsViewControllerRatingStarsCell
}

extension RatingStarsViewController.RatingStarsCell {
    final class Model {
        
        let title: String
        var score: Double?
        
        init(title: String) {
            self.title = title
        }
        
    }
}
