//
//  Form.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 23/11/20.
//

import Foundation

class Form: Codable {
    
    init(pilar: String,title: String, questions: [Question] = []) {
        self.pilar = pilar
        self.title = title
        self.questions = questions
    }
    
    var pilar: String
    var title: String
    var questions: [Question] = []
    var result: Float {
        let answeredQuestions = questions.filter{$0.isAnswered}
        let chosenAlternatives = answeredQuestions.compactMap{$0.chosenAlternatives}
        
        let value = chosenAlternatives.reduce(0) { (partial, alternatives) -> Float in
            let alternativeReduce = alternatives.reduce(0) { (partialReduce, alternative) -> Float in
                partialReduce+alternative.value
            }
            return partial+alternativeReduce
        }
        return value
    }
    
    var numberOfAnswered: Int {
        questions.filter({$0.isAnswered}).count
    }
}

