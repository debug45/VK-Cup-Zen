//
//  UIDevice.swift
//  Zen
//
//  Created by Sergey Moskvin on 31.01.2023.
//

import UIKit

extension UIDevice {
    
    var typeName: String {
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
    
}
