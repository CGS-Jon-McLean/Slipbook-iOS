//
//  SBReceiptImageViewController.swift
//  Slipbook
//
//  Created by Jon on 24/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBReceiptImageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: Variables and Outlets
    
    @IBOutlet var tableView: UITableView!
    
    var receiptImagesList: Array<UIImage> = []
    
    var cache = SBLocalTempSave()
    
    // MARK: - View Controller Method Implementations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Take Photo", style: .Plain, target: self, action: Selector("openCamera"))
    }
    
    // MARK: - Table View DataSource/Delegate method implementations
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! SBImageCell
        cell.addCell(receiptImagesList[indexPath.row])
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptImagesList.count
    }
    
    // MARK: - Camera Implementation
    func openCamera() {
        println("Open Camera function run")
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.Camera
            imag.allowsEditing = false
            
            self.presentViewController(imag, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        //capturedImage = image
        if(image == nil) {
            var controller = UIAlertController(title: "You need to take a photo", message: "To continue you must take a photo using the camera", preferredStyle: .Alert)
            var okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { UIAlertAction in
                println("Image was nil. Canceling...")
            })
            
            controller.addAction(okAction)
            self.presentViewController(controller, animated: true, completion: nil)
            
        }else {
            //println("Image taken")
            receiptImagesList.append(image)
            tableView.reloadData()
        }
        println("Image captured")
    }
    
    // MARK: - Tab Bar Delegate method implementations
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        self.cacheFields()
    }
    
    // MARK: - Other Methods
    func cacheFields() {
        cache.save(nil, category: nil, spent: nil, store: nil, productImages: nil, receiptImages: receiptImagesList)
    }
    
    
}
