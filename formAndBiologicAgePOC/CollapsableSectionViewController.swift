//
//  CollapsableSectionViewController.swift
//  formAndBiologicAgePOC
//
//  Created by Bruno Cardoso Ambrosio on 25/11/20.
//

import UIKit

class CollapsableSectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var hiddenSections: Set<Int> = []
    
    @IBOutlet weak var tableView: UITableView!
    var manager = JSONManager<[Form]>()
    var forms: [Form] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib.init(nibName: "TableHeaderFooterView", bundle: .main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier:TableHeaderFooterView.identifier)
        let cellNib = UINib.init(nibName: "AlternativeCell", bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: AlternativeCell.identifier)
        tableView.estimatedSectionHeaderHeight = 150
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !forms.isEmpty {
            return forms[1].questions.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hiddenSections.contains(section) {
            return 0
        }else {
            return forms[1].questions[section].alternatives.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlternativeCell.identifier, for: indexPath) as! AlternativeCell
        let alternative = forms[1].questions[indexPath.section].alternatives[indexPath.row]
        
        cell.enunciate.text = alternative.enunciation
        cell.complementaryText.text = alternative.text
        cell.chosenIcon.image = !alternative.isChosen ? UIImage(named: "circle") : UIImage(named: "checkmark.circle.fill")
        cell.chosenIcon.tintColor = !alternative.isChosen ? .black : .green
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderFooterView.identifier) as! TableHeaderFooterView
        headerView.contentView.backgroundColor = .white
        if !forms.isEmpty{
            let question = forms[1].questions[section]
            
            headerView.question.text = question.enunciation
            headerView.isAnsweredIcon.isHidden = !question.isAnswered
            headerView.isAnsweredIcon.image = !question.isAnswered ? UIImage(named: "circle") : UIImage(named: "checkmark.circle.fill")
            headerView.isAnsweredIcon.tintColor = !question.isAnswered ? .black : .green
            headerView.expandArrow.isHidden = !question.isAnswered
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hiddenSections.insert(indexPath.section)
        forms[1].questions[indexPath.section].isAnswered = true
        forms[1].questions[indexPath.section].alternatives[indexPath.row].isChosen = true
        tableView.reloadSections(IndexSet(indexPath), with: .automatic)
    }

}

