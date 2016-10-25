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
        let lastRow = tableView.numberOfRows(inSection: 0)
        let indexPath = NSIndexPath(row: lastRow, section: 0)
        
        tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
