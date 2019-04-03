//
//  ViewController.swift
//  To_Dos
//
//  Created by Rizul Sharma on 28/03/19.
//  Copyright © 2019 Rizul Sharma. All rights reserved.s
import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController{
    
    let realm = try! Realm()
    
    var toDoItems : Results<Item>?
    var selectedCategory : Category? {
        didSet{
            loaditems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            
            
            // TERNARY OPERATOR
            //VALUE OF = CONDITION ? VALUE IF TRUE : VALUE IF FALSE
            
            cell.accessoryType = item.done == true ? .checkmark : .none
        }
        else{
            cell.textLabel?.text = "no items added"
        }
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
        
        if let item = toDoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }
            catch{
                print("error saving new todos\(error)")
            }
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }
    
    
    @IBAction func addUttonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        let alert =  UIAlertController(title: "Add Item to todey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user clicks on Add Item button in UIalert
            
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textfield.text!
                        newItem.done = false
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                    
                }
                catch{
                    print("error saving todos \(error)")
                }
                
            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter you new Todey Here"
            textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func loaditems() {
        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

//}

extension ToDoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loaditems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                
            }
        }
    }
    
}
