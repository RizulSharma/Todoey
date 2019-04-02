//
//  CategoryViewController.swift
//  To_Dos
//
//  Created by Rizul Sharma on 02/04/19.
//  Copyright © 2019 Rizul Sharma. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategory()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }

   
    @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add a new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newcategory = Category(context: self.context)   ////WHAT SHOULD HAPPEN WHEN ADD IS PRESSED
            newcategory.name = textfield.text
            self.categories.append(newcategory)
            
            self.saveCategory()
            
        }
        alert.addTextField { (field) in
            
            textfield = field
        field.placeholder = "Enter New Category Here"
            
            
        }
        alert.addAction(action) //ADDING ACTION WE CREATED IN LINE 46-54 TO ALERT
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory() {
        
        do{
            try context.save()
        }
        catch{
            print("error saving categories \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadCategory(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categories = try context.fetch(request)
        }
        catch{
            print("error fetching database \(error)")
        }
        tableView.reloadData()
        
    }
    
    
}
