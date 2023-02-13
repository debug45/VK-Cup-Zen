//
//  UIColor.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

import UIKit

extension UIColor {
    
    enum Zen {
        
        private static let nameSpace = "Colors/"
        
        static let accent = UIColor(named: nameSpace + "Accent")!
        static let background = UIColor(named: nameSpace + "Background")!
        static let foreground = UIColor(named: nameSpace + "Foreground")!
        
    }
    
    func mixed(with admixture: UIColor) -> Self {
        var baseRed: CGFloat = 0
        var baseGreen: CGFloat = 0
        var baseBlue: CGFloat = 0
        var baseAlpha: CGFloat = 0
        
        getRed(&baseRed, green: &baseGreen, blue: &baseBlue, alpha: &baseAlpha)
        
        var admixtureRed: CGFloat = 0
        var admixtureGreen: CGFloat = 0
        var admixtureBlue: CGFloat = 0
        var admixtureAlpha: CGFloat = 0

        admixture.getRed(&admixtureRed, green: &admixtureGreen, blue: &admixtureBlue, alpha: &admixtureAlpha)
        
        return .init(
            red: baseRed + (admixtureRed - baseRed) * admixtureAlpha,
            green: baseGreen + (admixtureGreen - baseGreen) * admixtureAlpha,
            blue: baseBlue + (admixtureBlue - baseBlue) * admixtureAlpha,
            alpha: baseAlpha
        )
    }
    
}
