//
//  MandalaInformation.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 09/12/20.
//

import Foundation

class MandalaInformation: Codable {
    var mandala: String
    var greenText: String
    var yellowText: String
    var orangeText: String
    var redText: String
    
    
    init(mandala: String, greenText: String,
         yellowText: String, orangeText: String, redText: String) {
        self.mandala = mandala
        self.greenText = greenText
        self.yellowText = yellowText
        self.orangeText = orangeText
        self.redText = redText
    }
}
