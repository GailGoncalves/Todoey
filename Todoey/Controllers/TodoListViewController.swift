//
//  ViewController.swift
//  Todoey
//
//  Created by Gail Goncalves on 2019-08-20.
//  Copyright © 2019 Net Worthy Studio. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController, UISearchBarDelegate{
  
  //let defaults = UserDefaults.standard
    var itemArray = [Item]()
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  override func viewDidLoad() {
    super.viewDidLoad()
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
    
    //print (dataFilePath)
    
    loadItems()
    //if let items = defaults.array(forKey: "TodoListArray") as? [Item]
    //{
    //  itemArray = items
    //}
    
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    let item = itemArray[indexPath.row]
    cell.textLabel?.text = item.title
    if item.done == true {
      cell.accessoryType = .checkmark
    }
    else
    {
      cell.accessoryType = .none
    }
    
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // to delete
    //context.delete(itemArray[indexPath.row])
    //itemArray.remove(at: indexPath.row)
    
    if itemArray[indexPath.row].done == false {
      itemArray[indexPath.row].done = true
    }
    else
    {
      itemArray[indexPath.row].done = false
    }
    
    saveItems()
    
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add a to do item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

      
      let newItem = Item(context: self.context)
      newItem.title = textField.text!
      newItem.done = false
      
      self.itemArray.append(newItem)
      
      //self.defaults.set(self.itemArray, forKey: "TodoListArray")
      self.saveItems()
      
    }
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create New Item"
      textField = alertTextField
    }
      alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
      //alert.addTextField(configurationHandler: { (alertTextField) in
        //alertTextField.placeholder = "Create //new item"
        //print(alertTextField.text)
      //})
      //self.present(alert, animated: true, completion: nil)
      
    //}
  }
  func saveItems(){
    
    do{
      try context.save()
    }
    catch{
      print ("Error saving context \(error)")
      
    }
    
    
    self.tableView.reloadData()
  }
  func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
    //let request : NSFetchRequest<Item> = Item.fetchRequest()
    do{
      itemArray = try context.fetch(request)
    } catch{
      print("Error fetching data from context \(error)")
    }
    tableView.reloadData()
  }
  // or make extension below
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let request : NSFetchRequest<Item> = Item.fetchRequest()
    let predicate = NSPredicate(format: "title CONTAINS [cd] %@", searchBar.text! )
    //print(searchBar.text!)
    request.predicate = predicate
    let sortDescriptor = NSSortDescriptor(key : "title", ascending: true)
    request.sortDescriptors = [sortDescriptor]
    loadItems(with: request)
//    do{
//      itemArray = try context.fetch(request)
//    } catch{
//      print("Error fetching data from context \(error)")
//    }
    //tableView.reloadData()
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0{
      loadItems()
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
      }
      
    }
  }

}
//extension TodoListViewController : UISeachBarDelegate
//{
  //func searchBarSearchButtonClicked(_ searchBar: //UISearchBar)
  //{
    //let request : NSFetchRequest<Item> = Item.fetchRequest()
    //print(searchBar.text)
  //}
//}

