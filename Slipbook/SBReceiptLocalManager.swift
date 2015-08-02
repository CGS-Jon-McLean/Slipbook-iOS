//
//  ReceiptLocalManager.swift
//  Slipbook
//
//  Created by Jon on 30/07/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBReceiptLocalManager {
    
    var utils = SBImageToData()
    
    var receipts: Array<Dictionary<String, AnyObject>> = []
    
    func addReceipt(name: String, image: UIImage, dateTaken: String, spent: String, category: String) {
        
        var data = utils.imageToData(image)
        var dict = ["name": name, "image": data, "dateTaken": dateTaken, "spent": spent, "category": category]
        
        self.load()
        receipts.append(dict)
    }
    
    func save() {
        var ud = NSUserDefaults.standardUserDefaults()
        ud.setValue(receipts, forKey: "receiptsArray")
        ud.synchronize()
    }
    
    func load() {
        var ud = NSUserDefaults.standardUserDefaults()
        receipts = ud.valueForKey("receiptsArray") as! Array<Dictionary<String, AnyObject>>
        ud.synchronize()
    }
    
    func doesExist() -> Bool {
        var ud = NSUserDefaults.standardUserDefaults()
        if(ud.valueForKey("receiptsArray") != nil) {
            return true
        }else {
            return false
        }
    }
    
    func get(index: Int) -> Dictionary<String, AnyObject> {
        return receipts[index]
    }
    
    
}
