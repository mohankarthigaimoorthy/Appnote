//
//  showViewController.swift
//  notesApp
//
//  Created by Mohan K on 01/03/23.
//

import Foundation
import UIKit

class showViewController: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var notes: UITextView!
   
//
//    public var completion : ((String, String) -> Void)?
//
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.becomeFirstResponder()
        
//        titleText.text = noteTitle
//        notes.text = note
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(didTapEdit))
    }
    
    @objc func didTapEdit() {
        
        guard let noteTitle = titleText.text , let note = notes.text
        else {return}
        
//        if let text = text {
//            noteTitle.title = title
//            note.notes = notes
//        }
        
        if let text = titleText.text, !text.isEmpty, !notes.text.isEmpty {
//            completion?(text, notes.text)
        }
    }
}
