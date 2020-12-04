//
//  MandalaViewController.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 01/12/20.
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

enum MandalaColor: String {
    case green = "Verde"
    case yellow = "Amarelo"
    case orange = "Laranja"
    case red = "Vermelho"
}

class MandalaViewController: UIViewController {
    var mandalas: [Mandala] = []
    private var mandalasColor: [UIColor] = []
    var userBiologicalAge: Float = 22.0

    
    @IBOutlet weak var emotionalHealthMandala: UIImageView!
    @IBOutlet weak var physicalActivityMandala: UIImageView!
    @IBOutlet weak var sleepMandala: UIImageView!
    @IBOutlet weak var alimentationMandala: UIImageView!
    @IBOutlet weak var biologicalAgeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateMandalaColors()
        updateLabels()
    }
    
    private func updateLabels() {
        physicalActivityMandala.image = physicalActivityMandala.image?.withRenderingMode(.alwaysTemplate)
        physicalActivityMandala.tintColor = mandalasColor[0]
        alimentationMandala.image = alimentationMandala.image?.withRenderingMode(.alwaysTemplate)
        alimentationMandala.tintColor = mandalasColor[1]
        sleepMandala.image = sleepMandala.image?.withRenderingMode(.alwaysTemplate)
        sleepMandala.tintColor = mandalasColor[2]
        emotionalHealthMandala.image = emotionalHealthMandala.image?.withRenderingMode(.alwaysTemplate)
        emotionalHealthMandala.tintColor = mandalasColor[3]
        biologicalAgeLabel.text = "\(userBiologicalAge) \n anos"
    }
    
    private func calculateMandalaColors() {
        var activityMandalaColor: UIColor!
        var alimentationMandalaColor: UIColor!
        var sleepMandalaColor: UIColor!
        var emotionalHealthMandalaColor: UIColor!
        var biologicalAgeMandalaColor: UIColor!
        
        for index in 0...4 {
            let mandala = mandalas[index]
            switch index {
            case 0:
                activityMandalaColor = calculateActivityMandala(value: mandala.value)
                mandala.color = activityMandalaColor
            case 1:
                alimentationMandalaColor = calculateAlimentationMandala(value: mandala.value)
                mandala.color = alimentationMandalaColor
            case 2:
                sleepMandalaColor = calculateSleepMandala(value: mandala.value)
                mandala.color = sleepMandalaColor
            case 3:
                emotionalHealthMandalaColor = calculateEmotinalHealthMandala(value: mandala.value)
                mandala.color = emotionalHealthMandalaColor
            case 4:
                self.mandalasColor = [activityMandalaColor, alimentationMandalaColor, sleepMandalaColor, emotionalHealthMandalaColor]
                biologicalAgeMandalaColor = calculateBiologicalAgeMandala(mandalaColors: self.mandalasColor)
                mandala.color = biologicalAgeMandalaColor
                self.mandalasColor.append(biologicalAgeMandalaColor)
                self.userBiologicalAge = calculateBiologicalAge(userAge: 22, pilarValue: mandala.value)
            default:
                fatalError("Undefined mandala: \(mandala)")
            }
        }
    }
    
    /// Calculates the color of the activity mandala.
    /// - Parameter value: Total value of the answered questions.
    private func calculateActivityMandala(value: Float) -> UIColor {
        switch value {
        case 0.0:
            return .red
            
        case 1.0:
            return .yellow
            
        case 2.0:
            return .green
            
        case 3.0:
            return .green
            
        default:
            fatalError("Undefined value for activity pilar question: \(value)")
        }
    }
    
    /// Calculates the color of the alimentation mandala.
    /// - Parameter value: Total value of the answered questions.
    private func calculateAlimentationMandala(value: Float) -> UIColor {
        switch value {
        case _ where value <= 15:
            return .green
        case _ where value >= 16 && value <= 30:
            return .yellow
        case _ where value >= 31 && value <= 44:
            return .orange
        case _ where value >= 45 && value <= 60:
            return .red
        default:
            fatalError("Undefined value for alimentation pilar: \(value)")
        }
    }
    
    /// Calculates the color of the sleep mandala.
    /// - Parameter value: Total value of the answered questions.
    private func calculateSleepMandala(value: Float) -> UIColor {
        switch value {
        case _ where value >= 33 && value <= 44:
            return .green
        case _ where value >= 23 && value <= 32:
            return .yellow
        case _ where value >= 12 && value <= 22:
            return .orange
        case _ where value == 11:
            return .red
        default:
            fatalError("Undefined value for sleep pilar: \(value)")
        }
    }
    
    /// Calculates the color of the sleep mandala.
    /// - Parameter value: Total value of the answered questions.
    private func calculateEmotinalHealthMandala(value: Float) -> UIColor {
        switch value {
        case _ where value <= 10:
            return .green
        case _ where value >= 11 && value <= 20:
            return .yellow
        case _ where value >= 21 && value <= 30:
            return .orange
        case _ where value >= 31:
            return .red
        default:
            fatalError("Undefined value for emotional health pilar: \(value)")
        }
    }

    
    /// Calculates the color of the sleep mandala.
    /// - Parameter value: Total value of the answered questions.
    private func calculateBiologicalAgeMandala(mandalaColors: [UIColor]) -> UIColor {
        var value: Int = 0
        for color in mandalaColors {
            switch color {
            case .green:
                value -= 2
            case .yellow:
                value -= 1
            case .orange:
                value = 1
            case .red:
                value = 1
            default:
                fatalError("Different color found: \(color)")
            }
        }
        // TODO: Needs additional logic to return the right color
        return .green
    }
    
    /// - Parameter age: Current user age.
    /// - Returns: A tabulated multiplier, given a age.
    private func calculateBiologicalAge(userAge: Int, pilarValue: Float) -> Float {
    // TODO: Still need to confirm calculations with the costumer
        var multiplier: Float!
        var biologicalAge: Float!
        var value: Float = pilarValue
        
        switch userAge {
            case _ where userAge <= 18:
                multiplier = 1.0
                value = value<0 ? value * -1 : value // Geting value module

            case _ where userAge > 18 && userAge <= 25:
                multiplier = 0.25
                
            case _ where userAge > 25 && userAge <= 30:
                multiplier = 0.30
                
            case _ where userAge > 30 && userAge <= 40:
                multiplier = 0.40
                
            case _ where userAge > 40 && userAge <= 45:
                multiplier = 0.50
                
            case _ where userAge > 45 && userAge <= 50:
                multiplier = 0.55
                
            case _ where userAge > 50 && userAge <= 55:
                multiplier = 0.50
                
            case _ where userAge > 55 && userAge <= 60:
                multiplier = 0.45
                
            case _ where userAge > 60 && userAge <= 65:
                multiplier = 0.40
                
            case _ where userAge > 66 && userAge <= 70:
                multiplier = 0.35
                
            case _ where userAge > 70 && userAge <= 75:
                multiplier = 0.30
                
            case _ where userAge > 75:
                multiplier = 0.25
                
            default:
                multiplier = 1.0
        }
        
        biologicalAge = Float(userAge) - multiplier
        
        return biologicalAge
    }
}
