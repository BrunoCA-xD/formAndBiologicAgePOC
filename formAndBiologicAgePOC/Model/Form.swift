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
    var result: Float = 0
}
