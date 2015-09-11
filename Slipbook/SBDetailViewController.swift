//
//  SBDetailViewController.swift
//  Slipbook
//
//  Created by Jon on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBDetailViewController: UIViewController {
    
    var index: Int = 1
    
    //var local = SBReceiptLocalManager()
    
    var core = SBCoreData()
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var addButton: UIButton!
    
    var tStore = SBDetailViewStore()
    
    var utils = SBImageToData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        core.loadAndInsert()
        if(tStore.isIndex) {
            index = tStore.object as! Int
        }
        self.fill()
        //self.navigationController?.hidesBarsOnTap = true
        
        var button: UIBarButtonItem! = UIBarButtonItem(image: UIImage(named: "category"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showSelections"))
        //button.image = UIImage(named: "category")!
        //button.style = UIBarButtonItemStyle.Bordered
        self.navigationItem.rightBarButtonItem = button
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.hidesBarsOnSwipe = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fill() {
        var dict = core.receipts[index]
        println(core.receipts)
        println(index)
        var name = dict["name"] as! String
        println("Name: \(name)")
        
        //var imageData = dict["receiptImage"][0] as! NSData
        //var image = UIImage(data: imageData)
        println("test")
        var imageDataArray = dict["receiptImages"] as! Array<NSData>
        var imageArray: Array<UIImage> = []
        println(imageDataArray)
        println(dict)
        
        for i in imageDataArray {
            imageArray.append(utils.dataToImage(i))
        }
        
        var image: UIImage?
        
        if(imageArray.isEmpty) {
            imageView.image = nil
            println("Image Array is empty")
        }else {
            imageView.image = imageArray[0]
        }
    }
    
    func showSelections() {
        var actionSheet = UIAlertController(title: "Options", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        var infoAction = UIAlertAction(title: "Show/Edit Information", style: UIAlertActionStyle.Default, handler: { UIAlertAction in
            self.showInfo()
        })
        /*var statsAction = UIAlertAction(title: "Show Statistics", style: UIAlertActionStyle.Default, handler: { UIAlertAction in
            // open stats page
        })*/
        
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { UIAlertAction in
        
        })
        actionSheet.addAction(infoAction)
        //actionSheet.addAction(statsAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showInfo() {
        performSegueWithIdentifier("detailToEdit", sender: self)
        // need to fix
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailToEdit") {
            var controller = segue.destinationViewController as! SBShowEditInfoViewController
            controller.index = self.index
        }
    }
}
