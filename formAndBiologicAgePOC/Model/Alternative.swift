//
//  Alternative.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 23/11/20.
//

import Foundation

class Alternative: Codable, Equatable {
    static func == (lhs: Alternative, rhs: Alternative) -> Bool {
        lhs.enunciation == rhs.enunciation && lhs.value == rhs.value && lhs.isChosen == rhs.isChosen
    }
    
    
    init(enunciation: String,text: String, value: Float, isChosen: Bool) {
        self.text = text
        self.enunciation = enunciation
        self.value = value
        self.isChosen = isChosen
    }
    
    var enunciation: String
    var text: String
    var value: Float
    var isChosen: Bool
}

