//
//  SBAddViewController.swift
//  Slipbook
//
//  Created by Jon on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBAddViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var amountSpentField: UITextField!
    @IBOutlet var categoryField: UITextField!
    @IBOutlet var storeField: UITextField!
    
    var currentDate = NSDate()
    var stringDate = ""
    var dateFormatter = NSDateFormatter()
    
    var image: UIImage?
    
    var local = SBReceiptLocalManager()
    var tempStore = SBLocalTempSave()
    var utils = SBImageToData()
    
    var core = SBCoreData()
    
    // editing
    var editMode: Bool = false
    var index: Int = 0
    
    var productImages: Array<UIImage> = []
    var receiptImages: Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Done button
        self.tabBarController!.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector("doneButtonAction"))
        
        // Tap Recognizer
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        if(editMode == false) {
            // Dates
            dateFormatter.dateFormat = "dd/MM/yy"
            stringDate = dateFormatter.stringFromDate(currentDate)
            println(stringDate)
            if(tempStore.doesExist()) {
                println("idk")
                tempStore.load()
                println("loaded")
                var dictionary = tempStore.dictionary
                println("var dictionary")
                //println(dictionary)
                println("Finish printing viewDidLoad dictionary")
                var productImageData = dictionary["productImages"] as! Array<NSData>
                var receiptImageData = dictionary["receiptImages"] as! Array<NSData>
                
                for i in productImageData {
                    productImages.append(utils.dataToImage(i))
                }
                
                for i in receiptImageData {
                    receiptImages.append(utils.dataToImage(i))
                }
                
                //println(receiptImages)
            }
        }else {
            println(index)
            // load data into fields
            core.loadAndInsert()
            println(core.receipts)
            var dictionary = core.receipts[index]
            var name = dictionary["name"] as! String
            var category = dictionary["category"] as! String
            var store = dictionary["store"] as! String
            var spent = dictionary["spent"] as! String
            
            nameField.text = name
            amountSpentField.text = spent
            categoryField.text = category
            storeField.text = store
            
            tempStore.load()
            
            var array = tempStore.getValuesKeys()
            for i in array {
                if i == "name" {
                    nameField.text = tempStore.dictionary[i] as! String
                }
                
                if i == "category" {
                    categoryField.text = tempStore.dictionary[i] as! String
                }
                
                if i == "store" {
                    categoryField.text = tempStore.dictionary[i] as! String
                }
                
                if i == "spent" {
                    categoryField.text = tempStore.dictionary[i] as! String
                }
                
                if i == "productImages" {
                    var data = tempStore.dictionary[i] as! Array<NSData>
                    for j in data {
                        productImages.append(utils.dataToImage(j))
                    }
                }
                
                if i == "receiptImages" {
                    var data = tempStore.dictionary[i] as! Array<NSData>
                    for j in data {
                        receiptImages.append(utils.dataToImage(j))
                    }
                }
            }
            
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector("doneButtonAction"))
        if(tempStore.doesExist()) {
            println("idk")
            tempStore.load()
            println("loaded")
            var dictionary = tempStore.dictionary
            println("var dictionary 2")
            println(dictionary)
            println("Finish printing viewDidLoad dictionary")
            var productImageData = dictionary["productImages"] as! Array<NSData>
            var receiptImageData = dictionary["receiptImages"] as! Array<NSData>
            
            for i in productImageData {
                productImages.append(utils.dataToImage(i))
            }
            
            for i in receiptImageData {
                println("receipt images \(receiptImageData)") // will only run if there is data inside the array
                receiptImages.append(utils.dataToImage(i))
            }
            
            //println(receiptImages)
        }
    }
    
    /*func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if(item.tag != 1) {
            self.cacheFields()
        }else {
        }
    }*/
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        if(editMode == false) {
            //local.addReceipt(nameField.text, image: image!, dateTaken: stringDate, spent: amountSpentField.text, category: categoryField.text)
            //local.save()
            var byte = NSByteCountFormatter()
            var data = utils.imageToData(image!)
        }else {
            /*core.modifyEntry(self.index, name: nameField.text, store: storeField.text, category: categoryField.text, spent: amountSpentField.text, productImage: [UIImage(named: delete)!], receiptImage: [UIImage(named: "delete")!])*/
        }
        
        performSegueWithIdentifier("addToStandard", sender: self)
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        performSegueWithIdentifier("addToStandard", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func cacheFields() {
        tempStore.save(nameField.text, category: categoryField.text, spent: amountSpentField.text, store: storeField.text, productImages: productImages, receiptImages: receiptImages)
    }
    
    func doneButtonAction() {
        if(editMode) {
            core.modifyEntry(index, name: nameField.text, store: storeField.text, category: categoryField.text, spent: amountSpentField.text, productImages: productImages, receiptImage: receiptImages)
            self.performSegueWithIdentifier("addToStandard", sender: self)
        }else {
            core.save(nameField.text, receiptImage: receiptImages, productImage: productImages, dateTaken: currentDate, spent: amountSpentField.text, category: categoryField.text, store: storeField.text)
            println("Receipt Images: \(receiptImages)") // prints empty array
            self.performSegueWithIdentifier("addToStandard", sender: self)
        }
    }
}
