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
            typealias Element = ElementsMatchingCell.Model.Element
            
            let pairs: [Element: Element] = .init(
                uniqueKeysWithValues: $0.pairs.map {
                    (
                        .init(
                            id: UUID().uuidString,
                            title: $0.key
                        ),
                        
                        .init(
                            id: UUID().uuidString,
                            title: $0.value
                        )
                    )
                }
            )
            
            return .init(title: $0.title, pairs: pairs)
        }
    }
    
}
