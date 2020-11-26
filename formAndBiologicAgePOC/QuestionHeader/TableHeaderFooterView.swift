//
//  TableHeaderFooterView.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 25/11/20.
//

import UIKit

class TableHeaderFooterView: UITableViewHeaderFooterView, Identifiable {
    static var identifier: String {
        String(describing: TableHeaderFooterView.self)
    }
    @IBOutlet weak var expandArrow: UIImageView!
    
    @IBOutlet weak var isAnsweredIcon: UIImageView!
    @IBOutlet weak var question: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
