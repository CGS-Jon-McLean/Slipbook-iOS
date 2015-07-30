//
//  DisplayViewController.swift
//  Slipbook
//
//  Created by Jon on 26/07/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class DisplayViewController: UITableViewController {
    
    @IBOutlet var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            println("Thing")
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("Cell thing")
        var cell = tableView.dequeueReusableCellWithIdentifier("DisplayCell", forIndexPath: indexPath) as! DisplayViewCell
        cell.addCell("test")
        return cell
        
    }
}
