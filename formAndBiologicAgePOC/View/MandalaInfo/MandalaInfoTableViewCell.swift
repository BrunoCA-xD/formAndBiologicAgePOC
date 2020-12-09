//
//  MandalaInfoTableViewCell.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 04/12/20.
//

import UIKit

class MandalaInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var mandalaName: UILabel!
    @IBOutlet weak var mandalaInformation: UITextView!
    
    static var identifier: String {
        String(describing: MandalaInfoTableViewCell.self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperView.layer.cornerRadius = 8
        wrapperView.layer.borderWidth = 1
        wrapperView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
