//
//  ItemStore.swift
//  Homepwner
//
//  Created by Alecsandra Konson on 9/21/16.
//  Copyright © 2016 Apperator. All rights reserved.
//

import UIKit

class ItemStore { // no need to inherit from NSObject 
    
    var allItems = [Item]()

    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.insert(movedItem, at: toIndex)
    }
}
