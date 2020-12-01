//
//  MandalaViewController.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 01/12/20.
//

import UIKit

class MandalaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func getMultiplier(age: Int) -> Float {
        var multiplier: Float = 0.0
        
        switch age {
            case _ where age <= 18:
                multiplier = 1.0
                
            case _ where age > 18 && age <= 25:
                multiplier = 0.25
                
            case _ where age > 25 && age <= 30:
                multiplier = 0.30
                
            case _ where age > 30 && age <= 40:
                multiplier = 0.40
                
            case _ where age > 40 && age <= 45:
                multiplier = 0.50
                
            case _ where age > 45 && age <= 50:
                multiplier = 0.55
                
            case _ where age > 50 && age <= 55:
                multiplier = 0.50
                
            case _ where age > 55 && age <= 60:
                multiplier = 0.45
                
            case _ where age > 60 && age <= 65:
                multiplier = 0.40
                
            case _ where age > 66 && age <= 70:
                multiplier = 0.35
                
            case _ where age > 70 && age <= 75:
                multiplier = 0.30
                
            case _ where age > 75:
                multiplier = 0.25
                
            default:
                multiplier = 1.0
        }
        
        return multiplier
    }
}
