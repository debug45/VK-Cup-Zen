//
//  RatingStarsViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import UIKit

final class RatingStarsViewController: InteractiveFormatViewController<
    RatingStarsViewControllerRatingStarsCell.Model,
    RatingStarsViewControllerRatingStarsCell
> {
    
    override var navigationBarTitle: String {
        return InteractiveFormat.ratingStars.title
    }
    
    override var correspondingFormatGuide: (string: String, boldRanges: [NSRange]) {
        return LocalizedStrings.Scene.RatingStars.guide
    }
    
    override func createItemModelsPortion() -> [RatingStarsCell.Model] {
        return FakeData.ratingStarsModels.map {
            .init(title: $0.title)
        }
    }
    
}
