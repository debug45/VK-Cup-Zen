//
//  String.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

extension String {
    
    func calculateVisibleSize(font: UIFont, maxWidth: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let text = NSString(string: self)
        
        let attributes = [
            NSAttributedString.Key.font: font
        ]
        
        let maxSize = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let result = text.boundingRect(with: maxSize, options: [], attributes: attributes, context: nil).size
        
        return .init(
            width: ceil(result.width),
            height: ceil(result.height)
        )
    }
    
    func split(by separator: String) -> [String] {
        let fullString = Array(self)
        let fullStringLength = fullString.count
        
        let separator = Array(separator)
        let separatorLength = separator.count
        
        var results: [String] = []
        var currentWord: [Character] = []
        
        var fullStringIndex = 0
        
        let handleCurrentWordIfNeeded = {
            guard !currentWord.isEmpty else {
                return
            }
            
            results.append(
                .init(currentWord)
            )
            
            currentWord = []
        }
        
        while fullStringIndex < fullStringLength {
            let character = fullString[fullStringIndex]
            var isMatch = false
            
            if character == separator.first && fullStringIndex + separatorLength <= fullStringLength {
                isMatch = true
                
                if separator.count > 1 {
                    for separatorIndex in 1 ..< separatorLength {
                        if fullString[fullStringIndex + separatorIndex] != separator[separatorIndex] {
                            isMatch = false
                            break
                        }
                    }
                }
            }
                
            if isMatch {
                handleCurrentWordIfNeeded()
                
                results.append(
                    .init(separator)
                )
                
                fullStringIndex += separatorLength
            } else {
                currentWord.append(character)
                fullStringIndex += 1
            }
        }
        
        handleCurrentWordIfNeeded()
        return results
    }
    
}
