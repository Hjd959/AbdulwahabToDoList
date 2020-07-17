//
//  TodoListTableViewController.swift
//  AbdulwahabToDoList
//
//  Created by عبدالوهاب العنزي on 17/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {

    
    let itemArray = ["Abdulwahab","Abdullah","Alenezi"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row]
        // Configure the cell...

        return cell
    }
    

    //MARK: - TableView Delegate Mathod
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
}
