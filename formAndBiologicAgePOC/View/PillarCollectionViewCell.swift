//
//  PillarCollectionViewCell.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 25/11/20.
//

import UIKit

class PillarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pillarName: UILabel!
    @IBOutlet weak var pillarQuestions: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    
    var isCurrentPillar: Bool = false {
        didSet {
            if self.isCurrentPillar == true {
                self.wrapperView.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
                self.pillarName.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                self.pillarQuestions.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                self.wrapperView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                self.pillarName.textColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
                self.pillarQuestions.textColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)

            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wrapperView.layer.cornerRadius = 4
        self.wrapperView.layer.borderWidth = 1
        self.wrapperView.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
    }
    
    @IBAction func changePillar(_ sender: Any) {
        self.wrapperView.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
        self.pillarName.textColor = .white
        self.pillarQuestions.textColor = .white
    }
}
