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
        
        enum StepwisePoll {
            static let guide = NSLocalizedString("Scene.StepwisePoll.Guide", comment: "")
        }
        
        enum ElementsMatching {
            
            static let guide: (string: String, boldRanges: [NSRange]) = {
                let template = NSLocalizedString("Scene.ElementsMatching.Guide", comment: "")
                return LocalizedStrings.parseTemplate(template)
            } ()
            
            static let checkButton = NSLocalizedString("Scene.ElementsMatching.CheckButton", comment: "")
            
        }
        
        enum RatingStars {
            
            static let guide: (string: String, boldRanges: [NSRange]) = {
                let template = NSLocalizedString("Scene.RatingStars.Guide", comment: "")
                return LocalizedStrings.parseTemplate(template)
            } ()
            
        }
    }
    
    enum InteractiveFormat {
        
        static let stepwisePolls = NSLocalizedString("InteractiveFormat.StepwisePolls", comment: "")
        static let elementsMatching = NSLocalizedString("InteractiveFormat.ElementsMatching", comment: "")
        static let simpleTextGaps = NSLocalizedString("InteractiveFormat.SimpleTextGaps", comment: "")
        static let editableTextGaps = NSLocalizedString("InteractiveFormat.EditableTextGaps", comment: "")
        static let ratingStars = NSLocalizedString("InteractiveFormat.RatingStars", comment: "")
        
    }
    
    fileprivate static func parseTemplate(_ template: String) -> (string: String, boldRanges: [NSRange]) {
        var boldRanges: [NSRange] = []
        
        var currentTotalIndex = 0
        var lastTagIndex: Int?
        
        for substring in template.split(separator: "*") {
            let substringCount = substring.count
            
            if let lastTagIndexUnwrapped = lastTagIndex {
                boldRanges.append(
                    .init(location: lastTagIndexUnwrapped, length: substringCount)
                )
                
                lastTagIndex = nil
            } else {
                lastTagIndex = currentTotalIndex + substringCount
            }
            
            currentTotalIndex += substringCount
        }
        
        let string = template.replacingOccurrences(of: "*", with: "")
        return (string: string, boldRanges: boldRanges)
    }
    
}
