//
//  DisplayViewController.swift
//  Slipbook
//
//  Created by Jon on 30/07/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var local = SBReceiptLocalManager()
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if(local.doesExist()) {
            local.load()
        }else {
            println("No NSUserDefault found...")
            local.addReceipt("Hello", image: UIImage(named: "menu")!, dateTaken: "12/7/15", spent: "12.00")
            local.save()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return local.receipts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ReceiptCell", forIndexPath: indexPath) as! DisplayViewCell
        cell.addCell("Receipt 1", image: UIImage(named: "menu")!)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Cell found at \(indexPath.row) selected")
        index = indexPath.row
        performSegueWithIdentifier("standardToDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "standardToDetail") {
            var controller = segue.destinationViewController as! DetailViewController
            controller.index = index
        }
    }
    
    
}
