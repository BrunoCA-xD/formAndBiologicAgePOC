//
//  UITableView+RegisterNib.swift
//  AppDemias
//
//  Created by Lucas Antevere Santana on 14/05/20.
//  Copyright (c) 2020 Mascarados. All rights reserved.

import UIKit

extension UITableView {
    
    func registerCell(nibClass: IdentifiableView.Type) {
        
        let nib = UINib(nibName: nibClass.identifier, bundle: .main)
        self.register(nib, forCellReuseIdentifier: nibClass.identifier)
    }
    
    func registerHeaderFooter(nibClass: IdentifiableView.Type) {
        let nib = UINib(nibName: nibClass.identifier, bundle: .main)
        self.register(nib, forHeaderFooterViewReuseIdentifier: nibClass.identifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                        cellType: T.Type = T.self) -> T {
        let dequeueCell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        guard let cell = dequeueCell as? T else {
            preconditionFailure("Could not dequeue cell with identifier: \(cellType.identifier)")
        }
        return cell
    }
}
