//
//  MandalaInfoViewController.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 04/12/20.
//

import UIKit

class MandalaInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var mandalaViewControler: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib.init(nibName: MandalaInfoTableViewCell.identifier, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: MandalaInfoTableViewCell.identifier)
    }
}

// MARK: - Table view data source

extension MandalaInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MandalaInfoTableViewCell.identifier,
                                                 for: indexPath) as! MandalaInfoTableViewCell
        return cell
    }
}
