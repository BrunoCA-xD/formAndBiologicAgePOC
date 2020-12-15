//
//  ViewController.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 20/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var questionTimeline: UILabel!
    @IBOutlet weak var pillarIcon: UIImageView!
    
    var manager = JSONManager<[Form]>()
    var forms: [Form] = []
    
    private var collapsableSectionVC: CollapsableSectionViewController?
    
    var selectedNextItem: IndexPath = IndexPath(row: 0, section: 0) {
        willSet{
            if newValue != selectedNextItem {
                deselectitem()
            }
        }
        didSet{
            if let selecteds = collectionView.indexPathsForSelectedItems, !selecteds.contains(selectedNextItem){
                selectItem()
            }
        }
    }
    
    var selectedForm: Form? {
        didSet {
            collapsableSectionVC?.selectedForm = selectedForm
        }
    }
    
    var collectionCellID: String = "mandalaPillar"
    
    private func selectItem() {
        collectionView.selectItem(at: selectedNextItem, animated: true, scrollPosition: .left)
        collectionView(collectionView, didSelectItemAt: selectedNextItem)
        collectionView.reloadData()
        if !forms.isEmpty {
            selectedForm = forms[selectedNextItem.row]
        }
    }
    
    private func deselectitem() {
        collectionView.deselectItem(at: selectedNextItem, animated: true)
        collectionView(collectionView, didDeselectItemAt: selectedNextItem)
    }
    
    private func initializeCollapsableVC() {
        guard let colapsableViewController = children.first as? CollapsableSectionViewController else  {
            fatalError("Check storyboard for missing LocationTableViewController")
        }
        
        collapsableSectionVC = colapsableViewController
        colapsableViewController.vcController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "PillarCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: collectionCellID)
        
        initializeCollapsableVC()
        
        manager.getJSON(url: Bundle.main.url(forResource: "forms", withExtension: "json")) { (forms, error) in
            DispatchQueue.main.async { [self] in
                if let error = error{
                    print(error.localizedDescription)
                }
                if let forms = forms {
                    self.forms = forms
                    selectItem()
                    updateView()
                }
            }
        }
        
    }
    
    /// Updates navigation tittle, questions, timeline and icon.
    func updateView() {
        guard let pillar = selectedForm else {return}
        var answeredCount = pillar.numberOfAnswered
        let totalCount = pillar.questions.count
        answeredCount = answeredCount+(collapsableSectionVC?.numberOfShowingSection ?? 0)
        if answeredCount > totalCount{
            answeredCount = totalCount
        }
        
        self.questionTimeline.text = "Questão \(answeredCount) de \(totalCount)"
        self.pillarIcon.image = UIImage(named: "formImg\(selectedNextItem.row)")
        self.navigationItem.title = pillar.pilar
    }
    
    func formsCompleted(){
        performSegue(withIdentifier: "goToMandala", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMandala" {
            if let mandalaVC = segue.destination as? MandalaViewController {
                if Debug.isDebugMode == true {
                    mandalaVC.mandalas = Debug.mandalas
                } else {
                    for form in forms {
                        let formResult = form.result
                        let formPilar = form.pilar
                        let mandala = Mandala(pilarName: formPilar, value: formResult)
                        mandalaVC.mandalas.append(mandala)
                    }
                }
            }
        }
    }
}

// MARK:- CollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! PillarCollectionViewCell
        
        guard !forms.isEmpty else {return cell}
        
        let pillar = forms[indexPath.row]
        
        let totalCount = pillar.questions.count
        
        cell.pillarName.text = pillar.pilar
        cell.isCurrentPillar = selectedNextItem == indexPath
        cell.pillarQuestions.text = "\(pillar.numberOfAnswered)/\(totalCount)"
        guard indexPath.row == forms.count-1 else {
            return cell
            
        }
       let numberOfFormsAnswered = forms.reduce(0) { (partialResult, form) -> Int in
            if form.numberOfAnswered == form.questions.count {
                return partialResult+1
            }
            return partialResult
        }
        if numberOfFormsAnswered >= 4 {
            cell.isAvailable = true
        } else {
            cell.isAvailable = false
        }
        
        return cell
    }
    
    fileprivate func updateSelectedItem(_ indexPath: IndexPath){
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PillarCollectionViewCell {
            cell.isCurrentPillar = true
            updateView()
            selectedForm = forms[indexPath.row]
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
