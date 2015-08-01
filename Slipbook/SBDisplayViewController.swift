//
//  DisplayViewController.swift
//  Slipbook
//
//  Created by Jon on 30/07/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBDisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var local = SBReceiptLocalManager()
    var index: Int = 0
    
    var capturedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if(local.doesExist()) {
            local.load()
        }else {
            println("No NSUserDefault found...")
            local.addReceipt("Hello", image: UIImage(named: "menu")!, dateTaken: "12/7/15", spent: "12.00", category: "thing")
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
        var cell = tableView.dequeueReusableCellWithIdentifier("ReceiptCell", forIndexPath: indexPath) as! SBDisplayViewCell
        var dict = local.get(indexPath.row)
        var name = dict["name"] as! String
        var img = dict["image"] as! UIImage
        cell.addCell(name, image: img)
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
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
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
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.Camera
            imag.allowsEditing = false
            
            self.presentViewController(imag, animated: true, completion: nil)
        }else {
            
        }
    }
    
    
    @IBAction func switchToAdd(sender: UIBarButtonItem) {
        //performSegueWithIdentifier("standardToAdd", sender: self)
        openCamera()
    }
}
