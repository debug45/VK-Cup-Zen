//
//  StepwisePollViewController.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

import UIKit

final class StepwisePollViewController: InteractiveFormatViewController<
    StepwisePollViewControllerStepwisePollCell.Model,
    StepwisePollViewControllerStepwisePollCell
> {
    
    override var navigationBarTitle: String {
        return InteractiveFormat.stepwisePoll.title
    }
    
    override var correspondingFormatGuide: (string: String, boldRanges: [NSRange]) {
        return (LocalizedStrings.Scene.StepwisePoll.guide, [])
    }
    
    override func createItemModelsPortion() -> [StepwisePollCell.Model] {
        return FakeData.stepwisePollModels.map {
            return .init(
                title: $0.title,
                questions: $0.questions.map {
                    .init(
                        title: $0.title,
                        answers: $0.answers.map {
                            .init(
                                id: $0.id,
                                title: $0.title,
                                numberOfVotes: $0.numberOfVotes
                            )
                        },
                        correctAnswerID: $0.correctAnswerID
                    )
                }
            )
        }
    }
    
}
