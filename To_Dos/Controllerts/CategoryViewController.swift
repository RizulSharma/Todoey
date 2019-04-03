//
//  CategoryViewController.swift
//  To_Dos
//
//  Created by Rizul Sharma on 02/04/19.
//  Copyright © 2019 Rizul Sharma. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        loadCategory()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "NO CATEGORY ADDED YET"
        
        return cell
    }
    
    
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add a new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newcategory = Category()
            ////WHAT SHOULD HAPPEN WHEN ADD IS PRESSED
            newcategory.name = textfield.text!
            self.save(category: newcategory)
            
        }
        alert.addTextField { (field) in
            
            textfield = field
            field.placeholder = "Enter New Category Here"
            
            
        }
        alert.addAction(action) //ADDING ACTION WE CREATED IN LINE 46-54 TO ALERT
        present(alert, animated: true, completion: nil)
    }
    
    func save(category : Category) {
        
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("error saving categories \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadCategory(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexpath.row]
        }
    }

}
