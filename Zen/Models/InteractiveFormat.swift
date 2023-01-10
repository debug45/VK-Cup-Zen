//
//  InteractiveFormat.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

enum InteractiveFormat: CaseIterable {
    
    case stepwisePoll
    case elementMatching
    case simpleTextGaps
    case editableTextGaps
    case ratingStars
    
    var icon: String {
        switch self {
        case .stepwisePoll:
            return "📊"
        case .elementMatching:
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
        case .elementMatching:
            return localizedStrings.elementMatchings
        case .simpleTextGaps:
            return localizedStrings.simpleTextGaps
        case .editableTextGaps:
            return localizedStrings.editableTextGaps
        case .ratingStars:
            return localizedStrings.ratingStars
        }
    }
    
}
