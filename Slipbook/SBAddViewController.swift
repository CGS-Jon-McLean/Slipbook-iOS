//
//  SBAddViewController.swift
//  Slipbook
//
//  Created by Jon on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBAddViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var amountSpentField: UITextField!
    @IBOutlet var categoryField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var currentDate = NSDate()
    var stringDate = ""
    var dateFormatter = NSDateFormatter()
    
    var image: UIImage?
    
    var local = SBReceiptLocalManager()
    var utils = SBImageToData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Image Settings
        imageView.image = image
        imageView.alpha = 0.4
        
        // Tap Recognizer
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        // Dates
        dateFormatter.dateFormat = "dd/MM/yy"
        stringDate = dateFormatter.stringFromDate(currentDate)
        println(stringDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        
        local.addReceipt(nameField.text, image: image!, dateTaken: stringDate, spent: amountSpentField.text, category: categoryField.text)
        local.save()
        var byte = NSByteCountFormatter()
        var data = utils.imageToData(image!)
        println(data.length)
        
        performSegueWithIdentifier("addToStandard", sender: self)
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        performSegueWithIdentifier("addToStandard", sender: self)
    }
    
    
}
