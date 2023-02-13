//
//  UIDevice.swift
//  Zen
//
//  Created by Sergey Moskvin on 31.01.2023.
//

import UIKit

extension UIDevice {
    
    var className: String {
        let localizedStrings = LocalizedStrings.Other.Device.self
        
        switch userInterfaceIdiom {
            case .phone:
                return localizedStrings.iPhone
            case .pad:
                return localizedStrings.iPad
            case .mac:
                return localizedStrings.mac
            case .tv:
                return localizedStrings.appleTV
            case .carPlay:
                return  localizedStrings.carPlay
                
            case .unspecified:
                fallthrough
            @unknown default:
                return localizedStrings.unknown
        }
    }
    
    var environmentType: EnvironmentType {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return .preview
        }
        
        #if targetEnvironment(simulator)
            return .simulator
        #else
            return .device
        #endif
    }
    
    enum EnvironmentType {
        
        case device
        
        case simulator
        case preview
        
    }
    
}
