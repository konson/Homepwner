//
//  ItemsViewConroller.swift
//  Homepwner
//
//  Created by Alecsandra Konson on 9/19/16.
//  Copyright © 2016 Apperator. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    @IBAction func addNewItem(sender: AnyObject) {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = NSIndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                             moveRowAt sourceIndexPath: IndexPath,
                             to destinationIndexPath: IndexPath) {
        
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row,
                                  toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this itme?"
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel,
                                             handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete",
                                             style: .destructive,
                                             handler: { (action) -> Void in
                                                self.itemStore.removeItem(item: item)
                                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                                                
            })
            ac.addAction(deleteAction)
            
            // Present the alert conroller
            present(ac, animated: true, completion: nil)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
    }
    
    // Using dependency injection through a property to give this controller a store
    // Upon app launch, AppleDelegate.swift fires didFinishLaunchingWithOptions and there it instantiates 
    // this itemStore, copulating it with teh itemStore array.
    var itemStore: ItemStore!
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
        
    }
    
}
