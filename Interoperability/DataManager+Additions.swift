//
//  DataManager+Additions.swift
//  Interoperability
//
//  Created by Yohsuke Yamakawa on 1/27/16.
//  Copyright © 2016 DigitalCrafts. All rights reserved.
//

import Foundation

extension DataManager {
    func populate(){
        DataManager.sharedManager().createNewItemWithName("Milk",description: "Gallon of whole milk", category: "Dairy",price:2.99)
        DataManager.sharedManager().createNewItemWithName("Eggs",description: "Dozen Eggs", category: "Poultry",price:7.99)
        DataManager.sharedManager().createNewItemWithName("Cheese",description: "A Brick of Cheese", category: "Dairy",price:3.99)
        DataManager.sharedManager().createNewItemWithName("Ham",description: "half a pound of Ham", category: "Meat",price:4.99)
        DataManager.sharedManager().createNewItemWithName("Phish Food",description: "Pint of Ice Cream", category: "Dairy",price:3.99)
    }
}