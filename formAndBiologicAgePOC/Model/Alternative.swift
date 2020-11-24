//
//  Alternative.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 23/11/20.
//

import Foundation

class Alternative: Codable {
    
    init(enunciation: String, value: Float) {
        self.enunciation = enunciation
        self.value = value
    }
    
    var enunciation: String
    var value: Float
}

