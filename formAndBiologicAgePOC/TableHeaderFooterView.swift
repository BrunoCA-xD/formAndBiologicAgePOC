//
//  TableHeaderFooterView.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 25/11/20.
//

import UIKit

class TableHeaderFooterView: UIView, Identifiable {
    static var identifier: String {
        String(describing: self)
    }
    let textLabel: UILabel!
    
    init() {
        textLabel = UILabel()
    
        super.init(frame: .zero)
        
        textLabel.text =  "Section"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textLabel)
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
