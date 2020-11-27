//
//  ViewController.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 20/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var collectionCellID: String = "mandalaPillar"
    var isBiologicalAgeAvailable: Bool = false
    var defaultSetting: Bool = true {
        didSet {
            let indexPath = IndexPath(row: 0, section: 0)
            if let firstCell = self.collectionView.cellForItem(at: indexPath) as? PillarCollectionViewCell {
                firstCell.isCurrentPillar = self.defaultSetting ? true : false
            }
        }
    }
    var currentPillar: String = "Atividade Física" {
        didSet {
            self.navigationController?.title = self.currentPillar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "PillarCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: collectionCellID)
    }
}

// MARK:- CollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID,
                                                      for: indexPath) as! PillarCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.pillarName.text = "Atividade Física"
            cell.pillarQuestions.text = "0/1"
            cell.isCurrentPillar = self.defaultSetting ? true : false
        case 1:
            cell.pillarName.text = "Alimentação"
            cell.pillarQuestions.text = "0/15"
        case 2:
            cell.pillarName.text = "Sono"
            cell.pillarQuestions.text = "0/11"
        case 3:
            cell.pillarName.text = "Saúde Mental"
            cell.pillarQuestions.text = "0/8"
        case 4:
            cell.isAvailable = false
            cell.pillarName.text = "Idade Biológica"
            cell.pillarQuestions.text = "0/15"
        default:
            cell.pillarName.text = "AAAAA"
            cell.pillarQuestions.text = "AAAAA"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if defaultSetting {
            self.defaultSetting = false
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PillarCollectionViewCell {
            let pillarName = cell.pillarName.text
            self.currentPillar = pillarName!
            cell.isCurrentPillar = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PillarCollectionViewCell {
            cell.isCurrentPillar = false
        }
    }
}

// MARK:- TableViewDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "questionCell")
        cell.textLabel?.text = "AAAAA"
        return cell
    }
}
