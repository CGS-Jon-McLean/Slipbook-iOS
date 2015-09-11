//
//  SearchResultsController.swift
//  Slipbook
//
//  Created by Ben McLean on 29/08/2015.
//  Copyright (c) 2015 Arctro. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    var cellIdentifier = "ReceiptsCell"
    
    var receipts: [Dictionary<String, AnyObject>] = [Dictionary<String, AnyObject>]()
    var filteredReceipts: [Dictionary<String, AnyObject>] = [Dictionary<String, AnyObject>]()
    
    var predefinedSearch = "";
    
    var sortCache = SBLocalSortCache()
    
    override func viewDidLoad() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "potatoface")
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        filteredReceipts.removeAll(keepCapacity: true)
        
        filteredReceipts = SBSearch.searchDictionary(receipts, keys: ["name","category","spent"], queryString: searchString)!
        
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredReceipts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("potatoface", forIndexPath: indexPath) as! UITableViewCell
        var dict: Dictionary<String, AnyObject>
        
        dict = filteredReceipts[indexPath.row]
        
        var name = dict["name"] as! String
        cell.textLabel!.text = name
        return cell
    }
}