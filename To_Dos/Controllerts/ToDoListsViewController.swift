//
//  ViewController.swift
//  To_Dos
//
//  Created by Rizul Sharma on 28/03/19.
//  Copyright © 2019 Rizul Sharma. All rights reserved.s
import UIKit
import CoreData

class ToDoListViewController: UITableViewController{

    var itemArray = [Item]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        loaditems()
        
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
        
        saveItems()
        
        tableView.reloadData()
        
        
    }
    
    @IBAction func addUttonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
       let alert =  UIAlertController(title: "Add Item to todey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user clicks on Add Item button in UIalert
            
            
            let newItem = Item(context:self.context)
            newItem.title = textfield.text!
            newItem.done = false
            
            
            self.itemArray.append(newItem)
        
            
            // TO SAVE THE DATA LOCALLY
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter you new Todey Here"
                textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveItems() {
        //SAVING DATA//
        do{
            try context.save()
        }
        catch{
            print("error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    
    func loaditems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
      
        // LOADING/FETCHING DATA//FOR THAT WE HAVE TO CREATE A REQUEST//
        do{
            itemArray = try context.fetch(request)
        }
        catch{
            print("error fetching data \(error)")
        }
        tableView.reloadData()
    }

}

extension ToDoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        
        loaditems(with: request)
        
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
