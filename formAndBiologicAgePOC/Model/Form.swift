//
//  Form.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 23/11/20.
//

import Foundation

class Form: Codable {
    
    init(title: String, questions: [Question] = []) {
        self.title = title
        self.questions = questions
    }
    
    var title: String
    var questions: [Question] = []
    var result: Float = 0
}
