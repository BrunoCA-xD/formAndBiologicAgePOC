//
//  AlternativeCell.swift
//  formAndBiologicAgePOC
//
//  Created by Giovani de Oliveira Coutinho on 25/11/20.
//

import UIKit

class AlternativeCell: UITableViewCell{
   
    @IBOutlet weak var layoutView: UIView!
    @IBOutlet weak var chosenIcon: UIImageView!
    @IBOutlet weak var enunciate: UILabel!
    @IBOutlet weak var complementaryText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutView.layer.cornerRadius = 4
        layoutView.layer.borderWidth = 1
        layoutView.layer.borderColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
