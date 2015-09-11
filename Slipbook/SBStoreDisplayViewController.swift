//
//  StoreDisplayViewController.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBStoreDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables and Outlets
    
    var coreData = SBCoreData()
    
    var stores: Array<String> = []
    
    var sortCache = SBLocalSortCache()
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coreData.loadAndInsert()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        for i in coreData.receipts {
            stores.append(i["store"] as! String)
        }
        
        stores = sortStores(stores)
    }
    
    // MARK: UITableViewDataSource and UITableViewDelegate Implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("StoreCell", forIndexPath: indexPath) as! SBStoreDisplayCell
        var storeName = stores[indexPath.row]
        cell.addCell(storeName)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sortCache.addVariable(stores[indexPath.row], cat: false, sort: true, confirm: true)
        println(sortCache.sort)
        
        self.tabBarController!.selectedIndex = 0 // Moves to first view
    }
    
    func sortStores(stores: Array<String>) -> Array<String>{
        var new: Array<String> = []
        for i in stores {
            if contains(new, i) {
                // do nothing as it already exists.
            }else {
                new.append(i)
            }
        }
        return new
    }
    
    

}
