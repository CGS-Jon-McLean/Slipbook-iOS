//
//  DisplayViewController.swift
//  Slipbook
//
//  Created by Jon on 30/07/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    //var local = SBReceiptLocalManager()
    var core = SBCoreData()
    
    var index: Int = 0
    
    var capturedImage: UIImage?
    
    var utils = SBImageToData()
    
    var searchByCat: Bool = false
    var searchByStore: Bool = false
    var cat: String = ""
    var store: String = ""
    
    var sortCache = SBLocalSortCache()
    
    var filteredResults: [Dictionary<String, AnyObject>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        println(core.loadAndReturn())
        
        core.loadAndInsert()
        
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
        
        var searchButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("searchButtonPressed"))
        self.tabBarController?.navigationItem.rightBarButtonItem = searchButton
        
        if(sortCache.sort == true) {
            if(sortCache.cat == true) {
                searchByCat = true
                searchByStore = false
                cat = sortCache.cache
            }else {
                searchByCat = false
                searchByStore = true
                store = sortCache.cache
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(true) {
            return self.filteredResults.count
        }else{
            return core.countElements()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ReceiptCell", forIndexPath: indexPath) as! SBDisplayViewCell
        var dict: Dictionary<String, AnyObject>
        
        if(true) {
            dict = filteredResults[indexPath.row]
        }else{
            dict = core.receipts[indexPath.row]
        }
        
        var name = dict["name"] as! String
        var img = dict["image"] as! NSData
        var image = utils.dataToImage(img)
        cell.addCell(name, image: image)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Cell found at \(indexPath.row) selected")
        index = indexPath.row
        performSegueWithIdentifier("standardToDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "standardToDetail") {
            var controller = segue.destinationViewController as! SBDetailViewController
            controller.index = index
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
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        filteredResults = SBSearch.searchDictionary(core.receipts, keys: (core.receipts[0] as Dictionary<String, AnyObject>).keys.array, queryString: searchString)!
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        filteredResults = SBSearch.searchDictionary(core.receipts, keys: (core.receipts[0] as Dictionary<String, AnyObject>).keys.array, queryString: self.searchDisplayController!.searchBar.text)!
        return true
    }
    
    /*func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        capturedImage = image
        if(image == nil) {
            var controller = UIAlertController(title: "You need to take a photo", message: "To continue you must take a photo using the camera", preferredStyle: .Alert)
            var okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { UIAlertAction in
                println("Image was nil. Canceling...")
            })
            
            controller.addAction(okAction)
            self.presentViewController(controller, animated: true, completion: nil)
            
        }else {
            self.performSegueWithIdentifier("standardToAdd", sender: self)
        }
        println("Image captured")
    }
    
    func openCamera() {
        println("Open Camera function run")
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.Camera
            imag.allowsEditing = false
            
            self.presentViewController(imag, animated: true, completion: nil)
        }else {
            
        }
    }*/
    
    
    @IBAction func switchToAdd(sender: UIBarButtonItem) {
        //performSegueWithIdentifier("standardToAdd", sender: self)
        //openCamera()
    }
    
    func addButtonPressed() {
        self.performSegueWithIdentifier("standardToAddTAB", sender: self)
        //openCamera()
    }
    
    func searchButtonPressed() {
        self.searchDisplayController.
    }
}
