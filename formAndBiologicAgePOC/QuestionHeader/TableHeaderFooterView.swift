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

class TableHeaderFooterView: UITableViewHeaderFooterView, Identifiable {
    static var identifier: String {
        String(describing: TableHeaderFooterView.self)
    }
    weak var delegate: TableHeaderFooterViewDelegate?
    var sectionIndex: Int = -1
    
    @IBAction func headerTap(_ sender: Any) {
        print("oie")
        delegate?.headerTapped(sectionIndex)
    }
    
    @IBOutlet weak var expandArrow: UIImageView!
    
    @IBOutlet weak var isAnsweredIcon: UIImageView!
    @IBOutlet weak var question: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        question.isUserInteractionEnabled = false
//        question.superview?.isUserInteractionEnabled = false
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
