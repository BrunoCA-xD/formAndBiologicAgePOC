//
//  CollapsableSectionViewController.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 25/11/20.
//

import UIKit

class CollapsableSectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nextAndContinueButton: UIButton!
    var hiddenSections: Set<Int> = []
    
    var vcController: ViewController?
    var selectedForm: Int! {
        didSet{
            setHiddenSections()
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var manager = JSONManager<[Form]>()
    var forms: [Form] = []
    
    var numberOfShowingSection: Int {
        answeringSection == -1 ? 1 : 0
    }
    
    var answeringSection: Int = -1
    
    @IBAction func nextButton(_ sender: Any) {
        if nextAndContinueButton.title(for: .normal) == "Próxima"{
            if answeringSection != -1 {
                hiddenSections.insert(answeringSection)
                answeringSection = -1
                tableView.reloadData()
            }
        } else {
            
            if let item = vcController?.selectedNextItem {
                guard item.row != 4 else {
                    performSegue(withIdentifier: "goToMandala", sender: nil)
                    return
                }
                let indexPath = IndexPath(row: item.row+1, section: 0)
                answeringSection = -1
                vcController?.selectedNextItem = indexPath
            }
        }
//        (parent as! ViewController).defaultSetting = true
        
    }
    
    func setHiddenSections(){
        hiddenSections = []
        if let selected = selectedForm, !forms.isEmpty{
            for i in 0..<forms[selected].questions.compactMap({$0.isAnswered ? $0 : nil}).count {
                hiddenSections.insert(i)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib.init(nibName: "TableHeaderFooterView", bundle: .main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier:TableHeaderFooterView.identifier)
        let cellNib = UINib.init(nibName: "AlternativeCell", bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: AlternativeCell.identifier)
        tableView.estimatedRowHeight  = 200
        
        
        manager.getJSON(url: Bundle.main.url(forResource: "forms", withExtension: "json")) { (forms, error) in
            DispatchQueue.main.async {
                if let error = error{
                    print(error.localizedDescription)
                }
                if let forms = forms {
                    self.forms = forms
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMandala" {
            if let mandalaVC = segue.destination as? MandalaViewController {
                for form in forms {
                    let formResult = form.result
                    let formPilar = form.pilar
                    let mandala = Mandala(pilarName: formPilar, value: formResult)
                    mandalaVC.mandalas.append(mandala)
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !forms.isEmpty {
            let answeredList = forms[selectedForm].questions.compactMap{$0.isAnswered ? $0 : nil}
            if forms[selectedForm].questions.count <= hiddenSections.count+1 {
                nextAndContinueButton.setTitle("Continuar", for: .normal)
            }else{
                nextAndContinueButton.setTitle("Próxima", for: .normal)
            }
            if forms[selectedForm].questions.count == answeredList.count {
                return answeredList.count
            }
            return answeredList.count + numberOfShowingSection
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hiddenSections.contains(section) {
            return 0
        }else {
            return forms[selectedForm].questions[section].alternatives.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlternativeCell.identifier, for: indexPath) as! AlternativeCell
        let alternative = forms[selectedForm].questions[indexPath.section].alternatives[indexPath.row]
        
        cell.enunciate.text = alternative.enunciation
        cell.complementaryText.text = alternative.text
        cell.chosenIcon.image = !alternative.isChosen ? UIImage(named: "circle") : UIImage(named: "checkmark.circle.fill")
        cell.chosenIcon.tintColor = !alternative.isChosen ? .black : .green
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderFooterView.identifier) as! TableHeaderFooterView
        headerView.contentView.backgroundColor = .white
        headerView.delegate = self
        headerView.sectionIndex = section
        if !forms.isEmpty{
            let question = forms[selectedForm].questions[section]
            
            headerView.question.text = question.enunciation
            headerView.isAnsweredIcon.isHidden = !question.isAnswered
            headerView.isAnsweredIcon.image = !question.isAnswered ? UIImage(named: "circle") : UIImage(named: "checkmark.circle.fill")
            headerView.isAnsweredIcon.tintColor = !question.isAnswered ? .black : .green
            headerView.expandArrow.image = hiddenSections.contains(section) ? UIImage(named: "chevron.down") : UIImage(named: "chevron.up")
            headerView.expandArrow.isHidden = !question.isAnswered
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let question = forms[selectedForm].questions[indexPath.section]
        if !question.isAnswered {
            answeringSection = indexPath.section
            question.isAnswered = true
            question.alternatives[indexPath.row].isChosen = true
            forms[selectedForm].result += question.alternatives[indexPath.row].value
        }else {
            if let chosenIndex = question.alternatives.firstIndex(where:{$0.isChosen}){
                if chosenIndex != indexPath.row {
                    question.alternatives[chosenIndex].isChosen = false
                    forms[selectedForm].result -= question.alternatives[chosenIndex].value
                    question.alternatives[indexPath.row].isChosen = true
                    forms[selectedForm].result += question.alternatives[indexPath.row].value
                }
            }
        }
        tableView.reloadData()
    }
}


extension CollapsableSectionViewController: TableHeaderFooterViewDelegate {
    func headerTapped(_ sectionIndex: Int) {
        if forms[selectedForm].questions[sectionIndex].isAnswered {
            if hiddenSections.contains(sectionIndex){
                hiddenSections.remove(sectionIndex)
            }else {
                hiddenSections.insert(sectionIndex)
            }
            tableView.reloadSections([sectionIndex], with: .automatic)
        }
    }
    
}

