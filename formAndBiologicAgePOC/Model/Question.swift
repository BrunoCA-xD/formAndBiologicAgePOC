//
//  Question.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 23/11/20.
//

import Foundation

class Question: Codable {
    
    init(indice: Int? = nil, enunciation: String, alternatives: [Alternative] = []) {
        self.indice = indice
        self.enunciation = enunciation
        self.alternatives = alternatives
    }
    
    var indice: Int?
    var enunciation: String
    var alternatives: [Alternative]
    var canHaveMultipleAnswers: Bool = false
    
    var isAnswered: Bool {
        chosenAlternatives.count>0
    }
    var chosenAlternatives: [Alternative] {
        alternatives.filter{$0.isChosen}
    }
    
}
