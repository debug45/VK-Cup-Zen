//
//  ElementsMixingViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 29.01.2023.
//

import UIKit

final class ElementsMixingViewController: InteractiveFormatViewController<
    ElementsMixingViewControllerElementsMixingCell.Model,
    ElementsMixingViewControllerElementsMixingCell
> {
    
    override var navigationBarTitle: String {
        return InteractiveFormat.elementsMixing.title
    }
    
    override var correspondingFormatGuide: (string: String, boldRanges: [NSRange]) {
        return LocalizedStrings.Scene.ElementsMixing.guide
    }
    
    override func createItemModelsPortion() -> [ElementsMixingCell.Model] {
        return FakeData.elementsMixingModels.map {
            let possibleCombinations = $0.possibleCombinations.map {
                ElementsMixingCell.Model.PossibleCombination(
                    components: $0.components.map { .init(title: $0.title, count: $0.count) },
                    result: $0.result
                )
            }
            
            return .init(
                title: $0.title,
                resultIcon: $0.resultIcon,
                possibleCombinations: possibleCombinations,
                isOrderImportant: $0.isOrderImportant,
                isLowercasingAllowed: $0.isLowercasingAllowed
            )
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        
        guard motion == .motionShake else {
            return
        }
        
        let visibleCells = getVisibleCells().compactMap { $0 as? ElementsMixingCell }
        visibleCells.forEach { $0.checkResultIfAppropriate() }
    }
    
}
