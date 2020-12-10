//
//  InputCell.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 04/12/20.
//

import UIKit

protocol InputCellDelegate: class {
    func valueFieldValueChanged(cell: InputCell)
}

class InputCell: UITableViewCell {

    weak var delegate: InputCellDelegate?
    
    @IBOutlet weak var valueField: UITextField!
    
    @IBOutlet weak var txtLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.valueField.addTarget(self, action: #selector(self.valueFieldValueChanged), for: .editingChanged)
    }
    
    @objc func valueFieldValueChanged() {
        delegate?.valueFieldValueChanged(cell: self)
    }
}
