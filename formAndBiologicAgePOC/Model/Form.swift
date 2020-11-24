//
//  Form.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 23/11/20.
//

import Foundation

class Form {
    
    init(title: String, question: [Question] = []) {
        self.title = title
        self.question = question
    }
    
    var title: String
    var question: [Question] = []
    var result: Float = 0
}
