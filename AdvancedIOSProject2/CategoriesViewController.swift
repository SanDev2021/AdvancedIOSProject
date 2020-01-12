//
//  ViewController.swift
//  AdvancedIOSProject2
//
//  Created by SanDEV on 2020-01-12.
//  Copyright © 2020 SanDEV. All rights reserved.
//

import UIKit
struct NotesFolder
{
    var name = String()
    var arrayNotes = [String]()
}


class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
     var Folders = [NotesFolder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func AddCategoryBTN(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Folder", message: "Enter a name for this folder.", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Name"
            }
            let saveAction = UIAlertAction(title: "Add Item", style: .default, handler: { alert -> Void in
                let nameTextField = alertController.textFields![0] as UITextField
                guard let folderName = nameTextField.text else
                {
                    return
                }
                
                if self.Folders.contains(where: { $0.name ==  folderName })
                {
                    //show alert if same name is tried to give to the folder
                    self.showAlertForDuplicateFolder(folderName: folderName)
                    return
                }
                
                let folder = NotesFolder(name: folderName, arrayNotes: [])
                
                self.Folders.append(folder)
                self.tableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive , handler: { (action : UIAlertAction!) -> Void in })
            
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        //show alert if dupliacte name is tried to give to the folder
        func showAlertForDuplicateFolder(folderName: String)
        {
            let alertController = UIAlertController(title: "Name Taken", message: "Please choose a different name.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: { (action : UIAlertAction!) -> Void in })
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
}

