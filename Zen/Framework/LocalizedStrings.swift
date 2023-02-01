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
            static let footer = NSLocalizedString("Scene.Main.Footer", comment: "")
            
            enum Subtitle {
                
                static let currentStage = NSLocalizedString("Scene.Main.Subtitle.CurrentStage", comment: "")
                static let previousStage = NSLocalizedString("Scene.Main.Subtitle.PreviousStage", comment: "")
                
            }
            
            enum AboutDeveloper {
                
                static let title = NSLocalizedString("Scene.Main.AboutDeveloper.Title", comment: "")
                static let content = NSLocalizedString("Scene.Main.AboutDeveloper.Content", comment: "")
                
            }
            
        }
        
        enum ElementsMixing {
            
            static let guide: (string: String, boldRanges: [NSRange]) = {
                let template = NSLocalizedString("Scene.ElementsMixing.Guide", comment: "")
                return LocalizedStrings.parseTemplate(template)
            } ()
            
            enum HelpAlert {
                
                static let title = NSLocalizedString("Scene.ElementsMixing.HelpAlert.Title", comment: "")
                
                static func numberOfElements(count: Int) -> String {
                    let template = NSLocalizedString("Scene.ElementsMixing.HelpAlert.NumberOfElements.Template", comment: "")
                    return .init(format: template, count)
                }
                
                static let closeButton = NSLocalizedString("Scene.ElementsMixing.HelpAlert.CloseButton", comment: "")
                
            }
            
            enum AddingHint {
                
                static let nonImportantOrder: (string: String, boldRanges: [NSRange]) = {
                    let template = NSLocalizedString("Scene.ElementsMixing.AddingHint.NonImportantOrder", comment: "")
                    return LocalizedStrings.parseTemplate(template)
                } ()
                
                static let importantOrder: (string: String, boldRanges: [NSRange]) = {
                    let template = NSLocalizedString("Scene.ElementsMixing.AddingHint.ImportantOrder", comment: "")
                    return LocalizedStrings.parseTemplate(template)
                } ()
                
                static let anyCounts: (string: String, boldRanges: [NSRange]) = {
                    let template = NSLocalizedString("Scene.ElementsMixing.AddingHint.AnyCounts", comment: "")
                    return LocalizedStrings.parseTemplate(template)
                } ()
                
            }
            
            enum CheckResult {
                
                static let button = NSLocalizedString("Scene.ElementsMixing.CheckResult.Button", comment: "")
                
                static func hint(deviceType: String) -> String {
                    let template = NSLocalizedString("Scene.ElementsMixing.CheckResult.Hint.Template", comment: "")
                    return .init(format: template, deviceType)
                }
                
            }
            
            static let resetButton = NSLocalizedString("Scene.ElementsMixing.ResetButton", comment: "")
            static let failure = NSLocalizedString("Scene.ElementsMixing.Failure", comment: "")
            
        }
        
        enum HapticSlider {
            
            static let guide = NSLocalizedString("Scene.HapticSlider.Guide", comment: "")
            
        }
        
        enum StepwisePoll {
            
            static let guide = NSLocalizedString("Scene.StepwisePoll.Guide", comment: "")
            
            enum CommitButton {
                
                static let nextQuestion = NSLocalizedString("Scene.StepwisePoll.CommitButton.NextQuestion", comment: "")
                static let showResults = NSLocalizedString("Scene.StepwisePoll.CommitButton.ShowResults", comment: "")
                
            }
            
        }
        
        enum ElementsMatching {
            
            static let guide: (string: String, boldRanges: [NSRange]) = {
                let template = NSLocalizedString("Scene.ElementsMatching.Guide", comment: "")
                return LocalizedStrings.parseTemplate(template)
            } ()
            
            static let checkButton = NSLocalizedString("Scene.ElementsMatching.CheckButton", comment: "")
            
        }
        
        enum SimpleTextGaps {
            
            static let guide: (string: String, boldRanges: [NSRange]) = {
                let template = NSLocalizedString("Scene.SimpleTextGaps.Guide", comment: "")
                return LocalizedStrings.parseTemplate(template)
            } ()
            
            static let checkButton = NSLocalizedString("Scene.SimpleTextGaps.CheckButton", comment: "")
            static let resetButton = NSLocalizedString("Scene.SimpleTextGaps.ResetButton", comment: "")
            
        }
        
        enum EditableTextGaps {
            
            static let guide = NSLocalizedString("Scene.EditableTextGaps.Guide", comment: "")
            static let checkButton = NSLocalizedString("Scene.EditableTextGaps.CheckButton", comment: "")
            
        }
        
        enum RatingStars {
            
            static let guide: (string: String, boldRanges: [NSRange]) = {
                let template = NSLocalizedString("Scene.RatingStars.Guide", comment: "")
                return LocalizedStrings.parseTemplate(template)
            } ()
            
        }
    }
    
    enum InteractiveFormat {
        
        static let elementsMixing = NSLocalizedString("InteractiveFormat.ElementsMixing", comment: "")
        static let hapticSlider = NSLocalizedString("InteractiveFormat.HapticSlider", comment: "")
        
        static let stepwisePolls = NSLocalizedString("InteractiveFormat.StepwisePolls", comment: "")
        static let elementsMatching = NSLocalizedString("InteractiveFormat.ElementsMatching", comment: "")
        static let simpleTextGaps = NSLocalizedString("InteractiveFormat.SimpleTextGaps", comment: "")
        static let editableTextGaps = NSLocalizedString("InteractiveFormat.EditableTextGaps", comment: "")
        static let ratingStars = NSLocalizedString("InteractiveFormat.RatingStars", comment: "")
        
    }
    
    enum Other {
        enum Device {
            
            static let iPhone = NSLocalizedString("Other.Device.iPhone", comment: "")
            static let iPad = NSLocalizedString("Other.Device.iPad", comment: "")
            
            static let mac = NSLocalizedString("Other.Device.Mac", comment: "")
            static let appleTV = NSLocalizedString("Other.Device.AppleTV", comment: "")
            static let carPlay = NSLocalizedString("Other.Device.CarPlay", comment: "")
            static let unknown = NSLocalizedString("Other.Device.Unknown", comment: "")
            
        }
    }
    
    fileprivate static func parseTemplate(_ template: String) -> (string: String, boldRanges: [NSRange]) {
        var boldRanges: [NSRange] = []
        
        var currentTotalIndex = 0
        var lastTagIndex: Int?
        
        for substring in template.components(separatedBy: "**") {
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
        
        let string = template.replacingOccurrences(of: "**", with: "")
        return (string: string, boldRanges: boldRanges)
    }
    
}
