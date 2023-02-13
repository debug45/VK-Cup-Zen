//
//  StepwisePollModel.swift
//  Zen
//
//  Created by Sergey Moskvin on 15.01.2023.
//

struct StepwisePollModel {
    
    let title: String
    let questions: [Question]
    
    struct Question {
        
        let title: String
        
        let answers: [Answer]
        let correctAnswerID: String
        
        struct Answer {
            
            let id: String
            let title: String
            let numberOfVotes: Int
            
        }
        
    }
    
}
