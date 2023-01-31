//
//  ElementsMixingModel.swift
//  Zen
//
//  Created by Sergey Moskvin on 29.01.2023.
//

struct ElementsMixingModel {
    
    let title: String
    let resultIcon: String
    
    let possibleCombinations: [PossibleCombination]
    let isOrderImportant: Bool
    
    struct PossibleCombination {
        
        let components: [(title: String, count: Int)]
        let result: String
        
    }
    
}
