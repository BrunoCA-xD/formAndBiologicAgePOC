//
//  Mandala.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 09/12/20.
//

import UIKit

class Mandala {
    var pilarName: String
    var value: Float
    var color: UIColor?
    
    init(pilarName: String, value: Float, color: UIColor? = nil) {
        self.pilarName = pilarName
        self.value = value
        self.color = color
    }
}
