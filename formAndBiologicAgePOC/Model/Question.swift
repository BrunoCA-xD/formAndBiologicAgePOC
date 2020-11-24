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
    
}
