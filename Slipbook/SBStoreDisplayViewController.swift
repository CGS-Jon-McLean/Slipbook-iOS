//
//  StoreDisplayViewController.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBStoreDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var coreData = SBCoreData()
    @IBOutlet var tableView: UITableView!
    
    var storeToSortBy: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coreData.loadAndInsert()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // MARK: UITableViewDataSource and UITableViewDelegate Implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreData.countElements()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("StoreCell", forIndexPath: indexPath) as! SBStoreDisplayCell
        var dict = coreData.receipts[indexPath.row]
        var storeName = dict["store"] as! String
        cell.addCell(storeName)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! SBStoreDisplayCell
        storeToSortBy = cell.storeLabel.text!
        
        self.performSegueWithIdentifier("storeToStandardSORT", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "storeToStandardSORT") {
            var vc = segue.destinationViewController as! SBDisplayViewController
            vc.storeSort = true
            vc.store = self.storeToSortBy
        }
    }
    
    // MARK: Checkers
    func checkCells() {
        /* 
            * Check if cell currently exists with the same title somewhere else and check how many copies there are. Once this is done delete them all from the table except 1.
            * Repeat for all cells.
        */
    }
    
    
    
    

}
