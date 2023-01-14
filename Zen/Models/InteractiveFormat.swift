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
        let strings = LocalizedStrings.InteractiveFormat.self
        
        switch self {
        case .stepwisePoll:
            return strings.stepwisePolls
        case .elementsMatching:
            return strings.elementsMatching
        case .simpleTextGaps:
            return strings.simpleTextGaps
        case .editableTextGaps:
            return strings.editableTextGaps
        case .ratingStars:
            return strings.ratingStars
        }
    }
    
}
