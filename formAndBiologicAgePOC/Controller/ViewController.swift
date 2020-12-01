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
    @IBOutlet weak var questionTimeline: UILabel!
    @IBOutlet weak var pillarIcon: UIImageView!
    
    private var colapsableSectionViewController: CollapsableSectionViewController?
  
    var collectionCellID: String = "mandalaPillar"
    var isBiologicalAgeAvailable: Bool = false
    var numberOfQuestions: Int = 1
    var numberOfAnsweredQuestions: Int = 0
    
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
        self.setDefaultSettings()
        let nibName = UINib(nibName: "PillarCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: collectionCellID)
        
        guard let colapsableViewController = children.first as? CollapsableSectionViewController else  {
          fatalError("Check storyboard for missing LocationTableViewController")
        }
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        if let firstCell = self.collectionView.cellForItem(at: indexPath) as? PillarCollectionViewCell {
            firstCell.isCurrentPillar = true
        }
        colapsableSectionViewController = colapsableViewController
        colapsableViewController.selectedForm = collectionView.indexPathsForSelectedItems?.first?.row ?? 3
    }
    
    /// Sets a default question timeline and pilla icon
    fileprivate func setDefaultSettings() {
        self.questionTimeline.text = "Questão \(numberOfAnsweredQuestions+1) de \(numberOfQuestions)"
        self.pillarIcon.image = UIImage(named: "physical-activity-icon")
    }
    
    /// Updates navigation tittle, questions, timeline and icon.
    fileprivate func updateView(pillarName: String?, icon: UIImage) {
        self.questionTimeline.text = "Questão \(numberOfAnsweredQuestions+1) de \(numberOfQuestions)"
        self.pillarIcon.image = icon
        self.navigationItem.title = pillarName
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
            cell.setNumberOfQuestions(numberOfQuestions: 1)
            cell.isCurrentPillar = self.defaultSetting ? true : false
            cell.setIcon(iconName: "physical-activity-icon")
        case 1:
            cell.pillarName.text = "Alimentação"
            cell.setNumberOfQuestions(numberOfQuestions: 15)
            cell.setIcon(iconName: "alimentation-icon")
        case 2:
            cell.pillarName.text = "Sono"
            cell.setNumberOfQuestions(numberOfQuestions: 11)
            cell.setIcon(iconName: "sleep-icon")
        case 3:
            cell.pillarName.text = "Saúde Emocional"
            cell.setNumberOfQuestions(numberOfQuestions: 8)
            cell.setIcon(iconName: "emotional-health-icon")
        case 4:
            cell.isAvailable = false
            cell.pillarName.text = "Idade Biológica"
            cell.setNumberOfQuestions(numberOfQuestions: 15)
            cell.setIcon(iconName: "biological-age-icon")
        default:
            cell.pillarName.text = "AAAAA"
            cell.pillarQuestions.text = "AAAAA"
        }
        
        self.numberOfQuestions = cell.getNumberOfQuestions()
        self.numberOfAnsweredQuestions = cell.getNumberOfAnsweredQuestions()
        cell.pillarQuestions.text = "\(numberOfAnsweredQuestions)/\(numberOfQuestions)"
        
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
            self.numberOfQuestions = cell.getNumberOfQuestions()
            self.numberOfAnsweredQuestions = cell.getNumberOfAnsweredQuestions()
            updateView(pillarName: pillarName, icon: cell.getIcon())
            self.colapsableSectionViewController?.selectedForm = indexPath.row
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
