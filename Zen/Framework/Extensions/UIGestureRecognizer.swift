//
//  UIGestureRecognizer.swift
//  Zen
//
//  Created by Sergey Moskvin on 14.01.2023.
//

import UIKit

extension UIGestureRecognizer {
    
    func releaseCurrentGesture() {
        for _ in 1 ... 2 {
            isEnabled.toggle()
        }
    }
    
}
