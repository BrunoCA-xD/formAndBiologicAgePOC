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
    
    private var numberOfQuestions: Int = 0
    private var numberOfAnsweredQuestions: Int = 0
    private var icon: UIImage = UIImage(named: "physical-activity-icon")!
    
    var isCurrentPillar: Bool = false {
        didSet {
            if isCurrentPillar {
                self.wrapperView.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
                self.pillarName.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                self.pillarQuestions.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                self.wrapperView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                self.wrapperView.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
                self.pillarName.textColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
                self.pillarQuestions.textColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
            }
        }
    }
    
    var isAvailable: Bool = true {
        didSet {
            self.isUserInteractionEnabled = self.isAvailable ? true : false
            self.wrapperView.layer.borderColor = isAvailable ? #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1) : #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 0.6)
            self.pillarName.textColor = isAvailable ? #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1) : #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 0.6)
            self.pillarQuestions.textColor = isAvailable ? #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1) : #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 0.6)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isUserInteractionEnabled = true
        self.wrapperView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.wrapperView.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
        self.pillarName.textColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
        self.pillarQuestions.textColor = #colorLiteral(red: 0.2941176471, green: 0.4509803922, blue: 1, alpha: 1)
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
    
    func setIcon(iconName: String) {
        guard let image = UIImage(named: iconName) else {
            print("Image named: \(iconName) does not exist")
            return
        }
        self.icon = image
    }
    
    func getIcon() -> UIImage {
        return icon
    }
    
    func setNumberOfQuestions(numberOfQuestions: Int) {
        self.numberOfQuestions = numberOfQuestions
    }
    
    func getNumberOfAnsweredQuestions() -> Int {
        return self.numberOfAnsweredQuestions
    }
    
    func getNumberOfQuestions() -> Int {
        return self.numberOfQuestions
    }
}
