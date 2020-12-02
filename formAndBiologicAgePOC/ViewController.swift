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
    
    var manager = JSONManager<[Form]>()
    var forms: [Form] = []
    
    private var colapsableSectionViewController: CollapsableSectionViewController?
    var selectedNextItem: IndexPath = IndexPath(row: 0, section: 0) {
        willSet{
            if newValue != selectedNextItem {
                collectionView.deselectItem(at: selectedNextItem, animated: true)
                collectionView(collectionView, didDeselectItemAt: selectedNextItem)
            }
        }
        didSet{
            if let selecteds = collectionView.indexPathsForSelectedItems, !selecteds.contains(selectedNextItem){
                collectionView.selectItem(at: selectedNextItem, animated: true, scrollPosition: .left)
                collectionView(collectionView, didSelectItemAt: selectedNextItem)
                collectionView.reloadData()
            }
        }
    }
    
    var collectionCellID: String = "mandalaPillar"
    var isBiologicalAgeAvailable: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "PillarCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: collectionCellID)
        
        guard let colapsableViewController = children.first as? CollapsableSectionViewController else  {
          fatalError("Check storyboard for missing LocationTableViewController")
        }
        
        collectionView.selectItem(at: selectedNextItem, animated: true, scrollPosition: .left)
        collectionView(collectionView, didSelectItemAt: selectedNextItem)
        colapsableSectionViewController = colapsableViewController
        colapsableViewController.vcController = self
        colapsableSectionViewController?.selectedForm = collectionView.indexPathsForSelectedItems?.first?.row ?? 3
        
        manager.getJSON(url: Bundle.main.url(forResource: "forms", withExtension: "json")) { (forms, error) in
            DispatchQueue.main.async {
                if let error = error{
                    print(error.localizedDescription)
                }
                if let forms = forms {
                    self.forms = forms
                    self.collectionView.reloadData()
//                    self.setDefaultSettings()
                    self.updateView()
                    colapsableViewController.forms = forms
                }
            }
        }
    }
    
    /// Updates navigation tittle, questions, timeline and icon.
    func updateView() {
        if forms.isEmpty{
            return
}
        let pillar = forms[selectedNextItem.row]
        var answeredCount = pillar.numberOfAnswered
        let totalCount = pillar.questions.count
        answeredCount = answeredCount+(colapsableSectionViewController?.numberOfShowingSection ?? 0)
        if answeredCount > totalCount{
            answeredCount = totalCount
        }
        
        self.questionTimeline.text = "Questão \(answeredCount) de \(totalCount)"
        self.pillarIcon.image = UIImage(named: "formImg\(selectedNextItem.row)")
        self.navigationItem.title = pillar.pilar
    }
}

// MARK:- CollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! PillarCollectionViewCell
        
        if forms.isEmpty{
         return cell
        }
        
        let pillar = forms[indexPath.row]
        
        let totalCount = pillar.questions.count
        
        cell.pillarName.text = pillar.pilar
        cell.isCurrentPillar = selectedNextItem == indexPath
        if indexPath.row == forms.count-1{
           let numberOfFormsAnswered = forms.reduce(0) { (partialResult, form) -> Int in
                if form.numberOfAnswered == form.questions.count {
                    return partialResult+1
                }
                return partialResult
            }
            cell.isAvailable = numberOfFormsAnswered == forms.count-1
        }
        cell.pillarQuestions.text = "\(pillar.numberOfAnswered)/\(totalCount)"
        
        return cell
    }
    
    fileprivate func updateSelectedItem(_ indexPath: IndexPath){
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PillarCollectionViewCell {
            cell.isCurrentPillar = true
            updateView()
            self.colapsableSectionViewController?.selectedForm = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedNextItem = indexPath
        updateSelectedItem(indexPath)
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
