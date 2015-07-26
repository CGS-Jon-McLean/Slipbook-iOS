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
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
