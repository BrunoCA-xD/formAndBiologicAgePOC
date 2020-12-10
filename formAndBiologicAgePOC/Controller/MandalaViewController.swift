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
    private var jsonManager = JSONManager<[MandalaInformation]>()
    private var mandalasInformation: [MandalaInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.registerNibs()
        self.mandalasColor = mandalaCalulator.calculateMandalaColors(mandalas: mandalas)
        self.userBiologicalAge = self.mandalaCalulator.calculateBiologicalAge(userAge: 22,
                                                                              biologicalAgePilarValue: mandalas[4].value)
        loadJson()
    }
    
    private func registerNibs() {
        let mandalaCell = UINib.init(nibName: ManadalaTableViewCell.identifier, bundle: .main)
        self.tableView.register(mandalaCell, forCellReuseIdentifier: ManadalaTableViewCell.identifier)
        let infoCell = UINib.init(nibName: MandalaInfoTableViewCell.identifier, bundle: .main)
        self.tableView.register(infoCell, forCellReuseIdentifier: MandalaInfoTableViewCell.identifier)
    }
    
    private func loadJson() {
        jsonManager.getJSON(url: Bundle.main.url(forResource: "mandalas-information", withExtension: "json")) { (informations, error) in
            DispatchQueue.main.async {
                if let error = error{
                    print(error.localizedDescription)
                }
                if let informations = informations {
                    self.mandalasInformation = informations
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func getInformantionText(color: UIColor, index: Int) -> String{
        switch color {
        case .green:
            return mandalasInformation[index].greenText
        case .yellow:
            return mandalasInformation[index].yellowText
        case .orange:
            return mandalasInformation[index].orangeText
        case .red:
            return mandalasInformation[index].redText
        default:
            fatalError("No information for the mandala color \(color)")
        }
        
    }
}

extension MandalaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let mandalaCell = tableView.dequeueReusableCell(withIdentifier: ManadalaTableViewCell.identifier,
                                                            for: indexPath) as! ManadalaTableViewCell
            mandalaCell.setColors(mandalasColor: self.mandalasColor)
            mandalaCell.setBiologicalAge()
            mandalaCell.biologicalAgeLabel.text = String(userBiologicalAge)
            return mandalaCell
        } else if indexPath.row < 5 {
            let index = indexPath.row - 1
            let infoCell = tableView.dequeueReusableCell(withIdentifier: MandalaInfoTableViewCell.identifier,
                                                     for: indexPath) as! MandalaInfoTableViewCell
            if !mandalasInformation.isEmpty {
                infoCell.mandalaName.text = mandalasInformation[index].mandala.uppercased()
                infoCell.mandalaName.textColor = mandalasColor[index]
                infoCell.mandalaInformation.text = self.getInformantionText(color: mandalasColor[index], index: index)
            }
            return infoCell
        } else {
            /// TODO: Biological age informations text are not done yet.
            let infoCell = tableView.dequeueReusableCell(withIdentifier: MandalaInfoTableViewCell.identifier,
                                                     for: indexPath) as! MandalaInfoTableViewCell
            infoCell.mandalaName.text = "IDADE BIOLÓGICA"
            infoCell.mandalaName.textColor = .blue
            infoCell.mandalaInformation.text = "Sua idade biológica é \(self.userBiologicalAge) anos."
            return infoCell
            
        }
    }
}

