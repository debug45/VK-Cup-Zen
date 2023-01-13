//
//  ElementsMatchingViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 12.01.2023.
//

import UIKit

final class ElementsMatchingViewController: InteractiveFormatViewController<
    ElementsMatchingViewControllerElementsMatchingCell.Model,
    ElementsMatchingViewControllerElementsMatchingCell
> {
    
    override var navigationBarTitle: String {
        return InteractiveFormat.elementsMatching.title
    }
    
    override var correspondingFormatGuide: String {
        return LocalizedStrings.Scene.ElementsMatching.guide
    }
    
    override func createItemModelsPortion() -> [ElementsMatchingCell.Model] {
        return FakeData.elementsMatchingModels.map {
            .init(title: $0.title, pairs: $0.pairs)
        }
    }
    
}
