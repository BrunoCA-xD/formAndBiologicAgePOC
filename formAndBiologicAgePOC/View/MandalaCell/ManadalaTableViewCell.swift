//
//  ManadalaTableViewCell.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 04/12/20.
//

import UIKit

class ManadalaTableViewCell: UITableViewCell {

    @IBOutlet weak var physicalActivityMandala: UIImageView!
    @IBOutlet weak var alimentationMandala: UIImageView!
    @IBOutlet weak var sleepMandala: UIImageView!
    @IBOutlet weak var emotionalHealthMandala: UIImageView!
    @IBOutlet weak var biologicalAgeLabel: UILabel!
    
    static var identifier: String {
        String(describing: ManadalaTableViewCell.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setColors(mandalasColor: [UIColor]) {
        physicalActivityMandala.image = physicalActivityMandala.image?.withRenderingMode(.alwaysTemplate)
        physicalActivityMandala.tintColor = mandalasColor[0]
        alimentationMandala.image = alimentationMandala.image?.withRenderingMode(.alwaysTemplate)
        alimentationMandala.tintColor = mandalasColor[1]
        sleepMandala.image = sleepMandala.image?.withRenderingMode(.alwaysTemplate)
        sleepMandala.tintColor = mandalasColor[2]
        emotionalHealthMandala.image = emotionalHealthMandala.image?.withRenderingMode(.alwaysTemplate)
        emotionalHealthMandala.tintColor = mandalasColor[3]
    }
    
    func setBiologicalAge() {
        
    }
    
}
