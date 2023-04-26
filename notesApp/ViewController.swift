//
//  ViewController.swift
//  notesApp
//
//  Created by Mohan K on 28/02/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table : UITableView!
    @IBOutlet weak var label : UILabel!
    
    var models: [(title: String, note: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        // Do any additional setup after loading the view.
        tableSetup()
    }
    func tableSetup() {
        table.delegate = self
        table.dataSource = self
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    @IBAction func didTapNewNote (){
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? entryViewController else{return}
        let model = models[indexPath.row]
        vc.title = "New Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.noteTitle = model.title
        vc.note = model.note
        vc.completion = { noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.models.insert((title: noteTitle, note: note), at: 0)
//            self.models.append((title: noteTitle, note: note))
            self.label.isHidden = true
            self.table.isHidden = false
            
            self.table.reloadData()
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
   
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
       
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? showViewController else{return}
        vc.navigationItem.largeTitleDisplayMode = .never
//        vc.completion = { noteTitle, note in
//            self.navigationController?.popToRootViewController(animated: true)
//            self.models.insert((title: noteTitle, note: note), at: .zero)
//            self.table.reloadData()
//            vc.title = "Note"
//
//////            self.table.isHidden = true
//////            self.table.reloadData()
//        }
            self.navigationController?.pushViewController(vc,animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        return 100
    }
}
