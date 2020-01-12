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
         self.title = "Notes Categories"
        // Do any additional setup after loading the view.
    }
//alert for adding categories or subject of the notes
    @IBAction func AddCategoryBTN(_ sender: UIBarButtonItem)
    {
        let alertController = UIAlertController(title: "New Notes Category", message: "Enter a name for this Category.", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Name"
            }
            let saveAction = UIAlertAction(title: "Add Here!!", style: .default, handler: { alert -> Void in
                let nameTextField = alertController.textFields![0] as UITextField
                guard let folderName = nameTextField.text else
                {
                    return
                }
                //cannot choose same name categories
                if self.Folders.contains(where: { $0.name ==  folderName })
                {
                 self.showAlertForDuplicateFolder(folderName: folderName)
                    return
                }
                //append data into folder array
                let folder = NotesFolder(name: folderName, arrayNotes: [])
            self.Folders.append(folder)
                self.tableView.reloadData()
            })
        //alert cancel action
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
    }}
    //Categories table view data source
    extension CategoriesViewController: UITableViewDataSource
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return Folders.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
            cell.selectionStyle = .blue
            cell.backgroundColor = .orange
            cell.accessoryType = .disclosureIndicator
            //cell.imageView?.image = UIImage(named: "folder-icon")
            cell.textLabel?.text = Folders[indexPath.row].name
            //number of notes shown in the folder
//            cell.textLabel?.text = String(describing: Folders[indexPath.row].arrayNotes.count)
            return cell
        }
    }



