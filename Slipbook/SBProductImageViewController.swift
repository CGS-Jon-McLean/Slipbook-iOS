//
//  ProductImageViewController.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBProductImageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate {
    
    // MARK: Variables and Outlets
    
    @IBOutlet var tableView: UITableView!
    
    var productImageList: Array<UIImage> = []
    
    var editMode: Bool = false
    var index: Int = 0
    
    var core = SBCoreData()
    var utils = SBImageToData()
    var tempStore = SBLocalTempSave()
    
    
    // MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        core.loadAndInsert()
        
        if(editMode) {
            var dictionary = core.receipts[index]
            var productImageData = dictionary["productImage"] as! Array<NSData>
            for i in productImageData {
                var j = i as NSData
                productImageList.append(utils.dataToImage(j))
            }
        }else {
            // do nothing. array should be empty if adding new element
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Take Photo", style: .Plain, target: self, action: Selector("openCamera"))
        //self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector("doneAction"))
        if(tempStore.doesExist()) {
            tempStore.load()
        }
    }
    
    
    // MARK: - UITableView method implementations
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productImageList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! SBImageCell
        cell.addCell(productImageList[indexPath.row])
        cell.selectionStyle = .None
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "productToAdd") {
            var vc = segue.destinationViewController as! SBAddViewController
            
        }
        
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
            productImageList.append(image)
            tableView.reloadData()
        }
        println("Image captured")
    }
    
    // MARK: - Tab Bar Method Implementations
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        cacheFields()
    }
    
    
    // MARK: - Other Functions
    func doneAction() { // Nav button action
        self.performSegueWithIdentifier("productToAdd", sender: self)
    }
    
    func cacheFields() {
        tempStore.save(nil, category: nil, spent: nil, store: nil, productImages: productImageList, receiptImages: nil)
    }


}
