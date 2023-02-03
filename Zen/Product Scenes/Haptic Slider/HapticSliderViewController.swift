//
//  HapticSliderViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 01.02.2023.
//

import CoreHaptics
import UIKit

final class HapticSliderViewController: InteractiveFormatViewController<
    HapticSliderViewControllerHapticSliderCell.Model,
    HapticSliderViewControllerHapticSliderCell
> {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !CHHapticEngine.capabilitiesForHardware().supportsHaptics {
            rightBarLabel.frame.size.width = 74
            showUnsupportedDeviceAlert()
        }
    }
    
    override var navigationBarTitle: String {
        return InteractiveFormat.hapticSlider.name
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
    
    private func showUnsupportedDeviceAlert() {
        let localizedStrings = LocalizedStrings.Scene.HapticSlider.UnsupportedDeviceAlert.self
        let description: String
        
        switch UIDevice.current.environmentType {
            case .simulator:
                description = localizedStrings.Description.simulator
            case .device, .preview:
                description = localizedStrings.Description.other
        }
        
        let alertController = UIAlertController(
            title: localizedStrings.title,
            message: description,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            .init(title: localizedStrings.closeButton, style: .default)
        )
        
        alertController.view.tintColor = .Zen.accent
        presentAlertController(alertController)
    }
    
}
