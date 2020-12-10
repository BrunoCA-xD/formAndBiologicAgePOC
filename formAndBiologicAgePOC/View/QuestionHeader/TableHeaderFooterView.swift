//
//  TableHeaderFooterView.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 25/11/20.
//

import UIKit

protocol TableHeaderFooterViewDelegate: class {
    func headerTapped(_ sectionIndex: Int)
}

class TableHeaderFooterView: UITableViewHeaderFooterView {
    weak var delegate: TableHeaderFooterViewDelegate?
    var sectionIndex: Int = -1
    
    @IBAction func headerTap(_ sender: Any) {
        delegate?.headerTapped(sectionIndex)
    }
    
    @IBOutlet weak var expandArrow: UIImageView!
    
    @IBOutlet weak var isAnsweredIcon: UIImageView!
    @IBOutlet weak var question: UILabel!
    
}
