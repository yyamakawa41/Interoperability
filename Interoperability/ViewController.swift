//
//  ViewController.swift
//  Interoperability
//
//  Created by Yohsuke Yamakawa on 1/27/16.
//  Copyright © 2016 DigitalCrafts. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var items : [ShoppingItem] = [ShoppingItem]()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButtonTouched(sender: AnyObject) {
        DataManager.sharedManager().getShoppingItemWithName(self.searchTextField.text, completed: {(returnedItem: ShoppingItem!, error: NSError!) in Void()
            self.items = [returnedItem]
            self.tableView.reloadData()
        })
    }
    
    @IBAction func populateButtonTouched(sender: AnyObject) {
        DataManager.sharedManager().populate()
        reloadTable()
    }
    
    func tableView(tableView:UITableView,numberOfRowsInSection section:Int) ->Int{
        return(self.items.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = self.items[indexPath.row]
        cell.textLabel?.text = "\(item.itemName!) - \(item.itemDescription!)"
        return cell
    }
    
    func reloadTable(){
        DataManager.sharedManager().getShoppingListWithCompletionBlock {
        [weak self] (items, error) -> Void in
            if items != nil {
                if let shoppingItems = items as? [ShoppingItem] {
                    self?.items = shoppingItems
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
            
        reloadTable()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

