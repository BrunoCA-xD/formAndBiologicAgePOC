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
    var currentPillar: String = "Atividade Física"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "PillarCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: collectionCellID)
    }
}

// MARK:- CollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID,
                                                      for: indexPath) as! PillarCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.pillarName.text = "Atividade Física"
            cell.pillarQuestions.text = "0/1"
        case 1:
            cell.pillarName.text = "Alimentação"
            cell.pillarQuestions.text = "0/15"
        case 2:
            cell.pillarName.text = "Sono"
            cell.pillarQuestions.text = "0/11"
        case 3:
            cell.pillarName.text = "Saúde Mental"
            cell.pillarQuestions.text = "0/8"
        default:
            cell.pillarName.text = "AAAAA"
            cell.pillarQuestions.text = "AAAAA"
        }
        
        if cell.pillarName.text == currentPillar {
            cell.isCurrentPillar = true
        } else {
            cell.isCurrentPillar = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PillarCollectionViewCell {
            print(currentPillar)
            guard let pillarName = cell.pillarName.text else { return }
            self.currentPillar = pillarName
            self.collectionView.reloadData()
            print(currentPillar)
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
