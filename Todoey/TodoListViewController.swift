//
//  ViewController.swift
//  Todoey
//
//  Created by Gail Goncalves on 2019-08-20.
//  Copyright © 2019 Net Worthy Studio. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let itemArray = ["Go to store","Swing","Pick up apples"]
  override func viewDidLoad() {
    super.viewDidLoad()
    
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


}

