//
//  ViewController.swift
//  Todoey
//
//  Created by Gail Goncalves on 2019-08-20.
//  Copyright © 2019 Net Worthy Studio. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
  
  let defaults = UserDefaults.standard
    var itemArray = [Item]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let newItem = Item()
    newItem.title = "Find Mike"
    itemArray.append(newItem)
    
    let newItem2 = Item()
    newItem2.title = "Item info 2"
    itemArray.append(newItem2)
    
    let newItem3 = Item()
    newItem3.title = "Item info 3"
    itemArray.append(newItem3)
    if let items = defaults.array(forKey: "TodoListArray") as? [Item]
    {
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
    //print(itemArray[indexPath.row])
    if itemArray[indexPath.row].done == false {
      itemArray[indexPath.row].done = true
    }
    else
    {
      itemArray[indexPath.row].done = false
    }
    tableView.reloadData()
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add a to do item", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
    
      let newItem = Item()
      newItem.title = textField.text!
      
      self.itemArray.append(newItem)
      
      self.defaults.set(self.itemArray, forKey: "TodoListArray")
      //self.defaults.set
      
      self.tableView.reloadData()
      
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


}

