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
        
        enum ElementsMatching {
            static let guide = NSLocalizedString("Scene.ElementsMatching.Guide", comment: "")
            static let checkButton = NSLocalizedString("Scene.ElementsMatching.CheckButton", comment: "")
        }
        
        enum RatingStars {
            static let guide = NSLocalizedString("Scene.RatingStars.Guide", comment: "")
        }
    }
    
    enum InteractiveFormat {
        
        static let stepwisePolls = NSLocalizedString("InteractiveFormat.StepwisePolls", comment: "")
        static let elementsMatching = NSLocalizedString("InteractiveFormat.ElementsMatching", comment: "")
        static let simpleTextGaps = NSLocalizedString("InteractiveFormat.SimpleTextGaps", comment: "")
        static let editableTextGaps = NSLocalizedString("InteractiveFormat.EditableTextGaps", comment: "")
        static let ratingStars = NSLocalizedString("InteractiveFormat.RatingStars", comment: "")
        
    }
    
}
