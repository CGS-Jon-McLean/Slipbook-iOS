//
//  CategoryDisplayViewController.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBCategoryDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories: Array<String> = []
    
    var selected: Bool = false
    var sortCache = SBLocalSortCache()
    var coreData = SBCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreData.loadAndInsert()
        for i in coreData.receipts {
            categories.append(i["category"] as! String)
        }
        
        categories = sortCategories(categories)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CategorySortCell", forIndexPath: indexPath) as! SBCategoryDisplayCell
        cell.addCell(categories[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected = true
        sortCache.addVariable(categories[indexPath.row], cat: true, sort: true, confirm: true)
        self.tabBarController!.selectedIndex = 0 // moves to first view
    }
    
    
    func sortCategories(categories: Array<String>) -> Array<String>{
        var new: Array<String> = []
        for i in categories {
            if contains(new, i) {
                // do nothing as it already exists.
            }else {
                new.append(i)
            }
        }
        return new
    }

}
