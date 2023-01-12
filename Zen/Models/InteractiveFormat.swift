//
//  InteractiveFormat.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

enum InteractiveFormat: CaseIterable {
    
    case stepwisePoll
    case elementsMatching
    case simpleTextGaps
    case editableTextGaps
    case ratingStars
    
    var icon: String {
        switch self {
        case .stepwisePoll:
            return "📊"
        case .elementsMatching:
            return "🔀"
        case .simpleTextGaps:
            return "💬"
        case .editableTextGaps:
            return "📝"
        case .ratingStars:
            return "⭐️"
        }
    }
    
    var title: String {
        let localizedStrings = LocalizedStrings.InteractiveFormat.self
        
        switch self {
        case .stepwisePoll:
            return localizedStrings.stepwisePolls
        case .elementsMatching:
            return localizedStrings.elementsMatching
        case .simpleTextGaps:
            return localizedStrings.simpleTextGaps
        case .editableTextGaps:
            return localizedStrings.editableTextGaps
        case .ratingStars:
            return localizedStrings.ratingStars
        }
    }
    
}
