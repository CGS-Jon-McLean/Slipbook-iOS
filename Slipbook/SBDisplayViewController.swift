//
//  DisplayViewController.swift
//  Slipbook
//
//  Created by Jon on 30/07/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    //var local = SBReceiptLocalManager()
    var core = SBCoreData()
    
    var index: Int = 0
    
    var capturedImage: UIImage?
    
    var utils = SBImageToData()
    
    var predefinedSearch:String = ""
    
    var searchController: UISearchController!
    
    var filteredResults: [Dictionary<String, AnyObject>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        core.loadAndInsert()
        tableView.reloadData()
        
        println("hiuy9wijopuw")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        println("View loaded")
        
        if self.navigationController == nil {
            println("nav controller is nil")
        }
        
        if self.navigationItem.rightBarButtonItem == nil {
            println("Right button is nil")
        }
        
        var addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addButtonPressed"))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
        
        self.tabBarController?.title = "SlipBook"
        
        let resultsController = SearchResultsController()
        resultsController.receipts = core.receipts
        searchController = UISearchController(searchResultsController: resultsController)

        
        println("search term" + predefinedSearch)
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Enter a search term"
        searchBar.scopeButtonTitles = []
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var sortCache = SBLocalSortCache()
        println("View did appear")
        println("Sort: \(sortCache.sort)")
        if(sortCache.sort) {
            println("test sort thing \(sortCache.sort)")
            setSearchBarText(sortCache.cache)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return core.countElements()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ReceiptCell", forIndexPath: indexPath) as! SBDisplayViewCell
        var dict: Dictionary<String, AnyObject>
        
        dict = core.receipts[indexPath.row]
        
        var name = dict["name"] as! String
        cell.addCell(name)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Cell found at \(indexPath.row) selected")
        index = indexPath.row
        
        var tStore = SBDetailViewStore()
        tStore.addObject(index, isIndexParam: true)
        
        performSegueWithIdentifier("standardToDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "standardToDetail") {
            //var controller = segue.destinationViewController as! SBDetailViewController
            //controller.index = index
            var tStore = SBDetailViewStore()
            println(tStore.object)
            
            //tStore.addObject(index, isIndexParam: true)
        }
        
        if(segue.identifier == "standardToAdd") {
            var controller = segue.destinationViewController as! SBAddViewController
            controller.image = capturedImage
            println("Executed standardToAdd segue")
        }
        
        if(segue.identifier == "standardToAddTAB") {
            // use temp save
        }
    }
    
    @IBAction func switchToAdd(sender: UIBarButtonItem) {
        //performSegueWithIdentifier("standardToAdd", sender: self)
        //openCamera()
    }
    
    func addButtonPressed() {
        self.performSegueWithIdentifier("standardToAddTAB", sender: self)
    }
    func searchButtonPressed() {
        
    }
    
    func setSearchBarText(text: String){
        var sortCache = SBLocalSortCache()
        println("Cache display: " + sortCache.cache)
        println("test \(text)")
        var searchBar = searchController.searchBar
        searchBar.text = text
        searchBar.becomeFirstResponder()
    }
}
