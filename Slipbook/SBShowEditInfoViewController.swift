//
//  SBShowInfoViewController.swift
//  Slipbook
//
//  Created by Jon on 2/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBShowEditInfoViewController: UIViewController {
    
    var index: Int = 4
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var amountSpentField: UITextField!
    @IBOutlet var categoryField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var local = SBReceiptLocalManager()
    var utils = SBImageToData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        local.load()
        loadInformation()
        
        var barButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("completedEditing"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func loadInformation() {
        println(index)
        //println(local.receipts[index])
        var dict = local.receipts[index]
        var name = dict["name"] as! String
        var data = dict["image"] as! NSData
        var image = utils.dataToImage(data)
        var category = dict["category"] as! String
        var spent = dict["spent"] as! String
        var date = dict["dateTaken"] as! String
        
        self.nameField.text = name
        self.amountSpentField.text = spent
        self.categoryField.text = category
        self.imageView.image = image
        self.imageView.alpha = 0.4
    }
    
    func completedEditing() {
        
        var dict = local.receipts[index]
        //var dict = local.receipts[index]
        var name = dict["name"] as! String
        var data = dict["image"] as! NSData
        var image = utils.dataToImage(data)
        var category = dict["category"] as! String
        var spent = dict["spent"] as! String
        var date = dict["dateTaken"] as! String
        
        if((nameField.text == name) && (amountSpentField.text == spent) && (categoryField.text == category)) {
            performSegueWithIdentifier("editToStandard", sender: self)
        }else {
            name = nameField.text
            category = categoryField.text
            spent = amountSpentField.text
            dict["name"] = name
            dict["category"] = category
            dict["spent"] = spent
            local.receipts[index] = dict
        }
        
    }

}
