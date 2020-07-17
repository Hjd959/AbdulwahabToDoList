//
//  TodoListTableViewController.swift
//  AbdulwahabToDoList
//
//  Created by عبدالوهاب العنزي on 17/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

class TodoListTableViewController: UITableViewController {

    
    var itemArray = [ITEM]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Save Data
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
     
        
        loadItem()
  
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

     
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
     

        if item.done == true {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
                return cell
    }
    

    //MARK: - TableView Delegate Mathod
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
//        context.delete(itemArray[indexPath.row])
//           itemArray.remove(at: indexPath.row)
//        
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }else{
             itemArray[indexPath.row].done = false
        }
        
        saveItems()

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func delet(_ sender: Any)
    {
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let aleart = UIAlertController(title: "Add New Todoey Item ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
           
            
            let newItem = ITEM(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
              self.tableView.reloadData()
          

        }
        aleart.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        aleart.addAction(action)
        present(aleart, animated: true, completion: nil)
    }
    
    func saveItems()
    {
      
        
        do
        {
           try context.save()
        }catch
        {
            print("Error Saving \(error)")
        }
        self.tableView.reloadData()
    }
    
    // Read Data
    func loadItem()
    {
        
        let request : NSFetchRequest<ITEM> = ITEM.fetchRequest()
        do {
           itemArray = try context.fetch(request)
        }catch{
            print("error Fetch \(error)")
        }
         tableView.reloadData()

    }
    

   
}

extension TodoListTableViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let request : NSFetchRequest<ITEM> = ITEM.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
                
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
      
        
        
        do {
            itemArray = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadItem()
            
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
            
           
        }
    }
    
}
