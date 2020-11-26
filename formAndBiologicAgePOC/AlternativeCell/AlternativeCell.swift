//
//  AlternativeCell.swift
//  formAndBiologicAgePOC
//
//  Created by Giovani de Oliveira Coutinho on 25/11/20.
//

import UIKit

class AlternativeCell: UITableViewCell,Identifiable {
    static var identifier: String {
        String(describing: AlternativeCell.self)
    }
    @IBOutlet weak var chosenIcon: UIImageView!
    @IBOutlet weak var enunciate: UILabel!
    @IBOutlet weak var complementaryText: UILabel!
}
