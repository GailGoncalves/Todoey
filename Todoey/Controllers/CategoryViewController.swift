//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gail Goncalves on 2019-08-26.
//  Copyright © 2019 Net Worthy Studio. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
  var categories = [Category]()
  
  //MARK: - Data Manipulation Methods
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
      loadCategories()
      
    }
  
  //MARK: - TableView datasource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    cell.textLabel?.text = categories[indexPath.row].name
    
    return cell
  }
  
  //MARK : - Add new categories

  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert )
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
      let newCategory = Category(context: self.context)
      newCategory.name = textField.text!
      
      self.categories.append(newCategory)
      
      self.saveCategories()
    }
    alert.addAction(action)
    
    alert.addTextField { (field) in
      textField = field
      textField.placeholder = "Add a new category"
      
      self.present(alert, animated: true, completion: nil)
    }
      
    
  }
  
  //MARK: TableView datasource methods
  
  
  //MARK: TableView Delegate methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToItems", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! TodoListViewController
    if let indexPath = tableView.indexPathForSelectedRow
    {
      destinationVC.selectedCategory = categories[indexPath.row]
    }
  }
  //MARK: Data manipulation methods
  func saveCategories(){
    
    do{
      try context.save()
    }
    catch{
      print ("Error saving category \(error)")
      
    }
    
    
    self.tableView.reloadData()
  }
  func loadCategories(){
    
    let request : NSFetchRequest<Category> = Category.fetchRequest()
    do{
      categories  = try context.fetch(request)
    } catch{
      print ("Error loading categories \(error)")
    }
    tableView.reloadData()
    
  }
  
  
}
