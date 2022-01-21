//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    
    var itemArray = ["Annay", "Janney", "Kenny"]
    let defaults = UserDefaults.standard  //persistance local

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{ //userdfaults bu olmaz ise kırırlır app
            
                itemArray = items
        }
    }

//MARK: -TableViewData Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: - TableView delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //print(indexPath.row)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
         
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: -Add New Item
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New TODOEY Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happend when users tapped
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray") //user defaults add
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
         textField = alertTextField
        
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

