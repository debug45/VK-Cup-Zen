//
//  LocalizedStrings.swift
//  Zen
//
//  Created by Sergey Moskvin on 10.01.2023.
//

import Foundation

enum LocalizedStrings {
    
    enum Scene {
        enum Main {
            static let title = NSLocalizedString("Scene.Main.Title", comment: "")
        }
    }
    
    enum InteractiveFormat {
        
        static let stepwisePolls = NSLocalizedString("InteractiveFormat.StepwisePolls", comment: "")
        static let elementMatchings = NSLocalizedString("InteractiveFormat.ElementMatchings", comment: "")
        static let simpleTextGaps = NSLocalizedString("InteractiveFormat.SimpleTextGaps", comment: "")
        static let editableTextGaps = NSLocalizedString("InteractiveFormat.EditableTextGaps", comment: "")
        static let ratingStars = NSLocalizedString("InteractiveFormat.RatingStars", comment: "")
        
    }
    
}
