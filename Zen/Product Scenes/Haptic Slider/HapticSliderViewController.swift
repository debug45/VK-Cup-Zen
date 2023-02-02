//
//  HapticSliderViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 01.02.2023.
//

import UIKit

final class HapticSliderViewController: InteractiveFormatViewController<
    HapticSliderViewControllerHapticSliderCell.Model,
    HapticSliderViewControllerHapticSliderCell
> {
    
    override var navigationBarTitle: String {
        return InteractiveFormat.hapticSlider.title
    }
    
    override var correspondingFormatGuide: (string: String, boldRanges: [NSRange]) {
        return LocalizedStrings.Scene.HapticSlider.guide
    }
    
    override func createItemModelsPortion() -> [HapticSliderCell.Model] {
        return FakeData.hapticSliderModels.map {
            .init(
                title: $0.title,
                minExample: .init(title: $0.minExample.title, value: $0.minExample.value),
                maxExample: .init(title: $0.maxExample.title, value: $0.maxExample.value),
                target: .init(title: $0.target.title, value: $0.target.value)
            )
        }
    }
    
}
