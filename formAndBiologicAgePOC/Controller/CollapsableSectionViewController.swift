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
    
    var selectedForm: Form? {
        didSet{
            answeringSection = -1
            setHiddenSections()
            tableView.reloadData()
            vcController?.updateView()
            configureButton()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var manager = JSONManager<[Form]>()
    
    var textField: String? = ""
    var numberOfShowingSection: Int {
        answeringSection == -1 ? 1 : 0
    }
    
    var answeringSection: Int = -1
    
    @IBAction func nextButton(_ sender: Any) {
        textField = ""
        if nextAndContinueButton.title(for: .normal) == "Próxima"{
            if answeringSection != -1 {
                hiddenSections.insert(answeringSection)
                answeringSection = -1
                tableView.reloadData()
                vcController?.updateView()
            }
        } else {
            
            if let item = vcController?.selectedNextItem {
                guard item.row != 4 else {
                    vcController?.formsCompleted()
                    return
                }
                let indexPath = IndexPath(row: item.row+1, section: 0)
                answeringSection = -1
                vcController?.selectedNextItem = indexPath
            }
        }
    }
    
    func setHiddenSections(){
        hiddenSections = []
        if let selected = selectedForm{
            for i in 0..<selected.numberOfAnswered {
                hiddenSections.insert(i)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerHeaderFooter(nibClass: TableHeaderFooterView.self)
        tableView.registerCell(nibClass: AlternativeCell.self)
        tableView.registerCell(nibClass: InputCell.self)
        tableView.estimatedRowHeight  = 200
        
    }
    
    fileprivate func configureButton() {
        guard selectedForm != nil else {return}
        if numberOfShowingSection == 1 && selectedForm!.numberOfAnswered != selectedForm!.questions.count {
            nextAndContinueButton.isEnabled = false
            nextAndContinueButton.backgroundColor = .lightGray
        }else {
            nextAndContinueButton.isEnabled = true
            nextAndContinueButton.backgroundColor = .systemBlue
        }
        if selectedForm!.questions.count <= hiddenSections.count+1 {
            nextAndContinueButton.setTitle("Continuar", for: .normal)
        }else{
            nextAndContinueButton.setTitle("Próxima", for: .normal)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let selectedForm = selectedForm {
            configureButton()
            if selectedForm.questions.count == selectedForm.numberOfAnswered {
                return selectedForm.numberOfAnswered
            }
            return selectedForm.numberOfAnswered + numberOfShowingSection
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hiddenSections.contains(section) {
            return 0
        }else {
            return selectedForm?.questions[section].alternatives.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var resultCell: UITableViewCell!
        let alternative = selectedForm?.questions[indexPath.section].alternatives[indexPath.row]
        
        if alternative?.enunciation == "" {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InputCell.self)
            cell.delegate = self
            cell.valueField.text = textField
            cell.txtLabel?.text = alternative?.text
            cell.txtLabel.isHidden = alternative?.text == ""
            
            resultCell = cell
            
        }else {
           let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AlternativeCell.self)
            
            cell.enunciate.text = alternative?.enunciation
            cell.complementaryText.text = alternative?.text
            cell.chosenIcon.image = alternative?.isChosen != true ? UIImage(named: "circle") : UIImage(named: "checkmark.circle.fill")
            cell.chosenIcon.tintColor = alternative?.isChosen != true ? .black : .green
            resultCell = cell
        }
        
        return resultCell
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
        guard selectedForm != nil else {return headerView}
        
        let question = selectedForm!.questions[section]
        
        headerView.question.text = question.enunciation
        headerView.isAnsweredIcon.isHidden = !question.isAnswered
        headerView.isAnsweredIcon.image = !question.isAnswered ? UIImage(named: "circle") : UIImage(named: "checkmark.circle.fill")
        headerView.isAnsweredIcon.tintColor = !question.isAnswered ? .black : .green
        headerView.expandArrow.image = hiddenSections.contains(section) ? UIImage(named: "chevron.down") : UIImage(named: "chevron.up")
        headerView.expandArrow.isHidden = !question.isAnswered
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath) is InputCell {
            return
        }
        guard selectedForm != nil else {return}
        configureButton()
        let question = selectedForm!.questions[indexPath.section]
        let selectingAlternative = question.alternatives[indexPath.row]
        
        if !question.isAnswered {
            answeringSection = indexPath.section
            selectingAlternative.isChosen = true
            vcController?.collectionView.reloadData()
        }else {
            if question.canHaveMultipleAnswers {
                if selectingAlternative.isChosen {
                    selectingAlternative.isChosen = false
                    
                    if !question.isAnswered {
                        answeringSection = -1
                    }
                    
                }else {
                    let none = question.alternatives.last
                    if none?.isChosen == true{
                        none?.isChosen = false
                    }else {
                        if selectingAlternative == none {
                            question.alternatives.forEach{$0.isChosen = false}
                        }
                    }
                    selectingAlternative.isChosen = true
                }
            }else {
                if let alreadyChosenIndex = question.alternatives.firstIndex(where:{$0.isChosen}){
                    if alreadyChosenIndex != indexPath.row {
                        question.alternatives[alreadyChosenIndex].isChosen = false
                    }
                }
                selectingAlternative.isChosen = true
            }
        }
        
        tableView.reloadData()
    }
}


extension CollapsableSectionViewController: TableHeaderFooterViewDelegate {
    func headerTapped(_ sectionIndex: Int) {
        if selectedForm?.questions[sectionIndex].isAnswered == true {
            if hiddenSections.contains(sectionIndex){
                hiddenSections.remove(sectionIndex)
            }else {
                hiddenSections.insert(sectionIndex)
            }
            tableView.reloadSections([sectionIndex], with: .automatic)
        }
    }
    
}

extension CollapsableSectionViewController: InputCellDelegate {
    func valueFieldValueChanged(cell: InputCell) {
        guard let indexPath = tableView.indexPath(for: cell),
              let question = selectedForm?.questions[indexPath.section] else {return}
        
        if cell.valueField.hasText {
            answeringSection = indexPath.section
            question.alternatives.forEach{$0.isChosen = false}
            question.alternatives[indexPath.row].isChosen = true
        }else {
            answeringSection = -1
            question.alternatives.forEach{$0.isChosen = false}
        }
        textField = cell.valueField.text
        let nextIndex = IndexPath(row: indexPath.row+1, section: indexPath.section)
        tableView.reloadRows(at: [nextIndex], with: .none)
        print("rodou")
    }
}

