//
//  ViewController.swift
//  To_Dos
//
//  Created by Rizul Sharma on 28/03/19.
//  Copyright © 2019 Rizul Sharma. All rights reserved.
//
import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [item]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = item()
        newItem.title = "Find mike"
        itemArray.append(newItem)
        
        let newItem2 = item()
        newItem2.title = "kill demogorgon"
        itemArray.append(newItem2)
        
        let newItem3 = item()
        newItem3.title = "save the world"
        itemArray.append(newItem3)
        
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [item]{
            itemArray = items
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        
        // TERNARY OPERATOR
        //VALUE OF = CONDITION ? VALUE IF TRUE : VALUE IF FALSE
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        //above code is equivalent to below code
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
//
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        
    }
    
    @IBAction func addUttonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
       let alert =  UIAlertController(title: "Add Item to todey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user clicks on Add Item button in UIalert
            print("success")
            print(textfield.text!)
            
            let newItem = item()
            newItem.title = textfield.text!
            
            
            self.itemArray.append(newItem)
        
            
            // TO SAVE THE DATA LOCALLY
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter you new Todey Here"
                textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
}
