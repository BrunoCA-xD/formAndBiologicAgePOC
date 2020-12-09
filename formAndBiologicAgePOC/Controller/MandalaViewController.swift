//
//  MandalaViewController.swift
//  formAndBiologicAgePOC
//
//  Created by Matheus Oliveira on 01/12/20.
//

import UIKit

class MandalaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mandalas: [Mandala] = []
    private var mandalasColor: [UIColor] = []
    private var mandalaCalulator: MandalaCalculator = MandalaCalculator()
    private var userBiologicalAge: Float = 22.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        self.mandalasColor = mandalaCalulator.calculateMandalaColors(mandalas: mandalas)
        self.userBiologicalAge = self.mandalaCalulator.calculateBiologicalAge(userAge: 22,
                                                                              biologicalAgePilarValue: mandalas[4].value)
    }
    
    private func registerNibs() {
        let mandalaCell = UINib.init(nibName: ManadalaTableViewCell.identifier, bundle: .main)
        self.tableView.register(mandalaCell, forCellReuseIdentifier: ManadalaTableViewCell.identifier)
        let infoCell = UINib.init(nibName: MandalaInfoTableViewCell.identifier, bundle: .main)
        self.tableView.register(infoCell, forCellReuseIdentifier: MandalaInfoTableViewCell.identifier)
    }
}

extension MandalaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let mandalaCell = tableView.dequeueReusableCell(withIdentifier: ManadalaTableViewCell.identifier,
                                                            for: indexPath) as! ManadalaTableViewCell
            mandalaCell.setColors(mandalasColor: self.mandalasColor)
            mandalaCell.setBiologicalAge()
            mandalaCell.biologicalAgeLabel.text = String(userBiologicalAge)
            return mandalaCell
        } else {
            let infoCell = tableView.dequeueReusableCell(withIdentifier: MandalaInfoTableViewCell.identifier,
                                                     for: indexPath) as! MandalaInfoTableViewCell
            return infoCell
        }
    }
}

