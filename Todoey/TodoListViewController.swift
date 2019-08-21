//
//  ViewController.swift
//  Todoey
//
//  Created by Gail Goncalves on 2019-08-20.
//  Copyright © 2019 Net Worthy Studio. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
  
  var defaults = UserDefaults.standard
    var itemArray = ["Go to store","Swing","Pick up apples"]
  override func viewDidLoad() {
    super.viewDidLoad()
    if let items = defaults.array(forKey: "TodoListArray") as? [String]
    {
      itemArray = items
    }
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    cell.textLabel?.text = itemArray[indexPath.row]
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print(itemArray[indexPath.row])
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
    {
      tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    else{
      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    let alert = UIAlertController(title: "Add a to do item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      self.itemArray.append(textField.text!)
      self.defaults.set(self.itemArray, forKey: "TodoListArray")
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

