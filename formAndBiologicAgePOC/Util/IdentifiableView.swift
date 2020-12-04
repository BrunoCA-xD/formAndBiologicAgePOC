//
//  IdentifiableView.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 04/12/20.
//

import UIKit

protocol IdentifiableView {
    static var identifier: String {get}
}

extension IdentifiableView {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: IdentifiableView{ }
extension UITableViewHeaderFooterView: IdentifiableView{ }
