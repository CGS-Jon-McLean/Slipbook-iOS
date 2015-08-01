//
//  ReceiptLocalManager.swift
//  Slipbook
//
//  Created by Jon on 30/07/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBReceiptLocalManager {
    
    var receipts: Array<Dictionary<String, AnyObject>> = []
    
    private var ud = NSUserDefaults.standardUserDefaults()
    private var utils = SBImageToData()
    
    func addReceipt(name: String, image: UIImage, dateTaken: String, spent: String, category: String) {
        
        var data = utils.imageToData(image)
        
        receipts.append(["name": name, "image": data, "dateTaken": dateTaken, "spent": spent, "category": category])
    }
    
    func save() {
        ud.setValue(receipts, forKey: "receiptsArray")
        ud.synchronize()
    }
    
    func load() {
        receipts = ud.valueForKey("receiptsArray") as! Array<Dictionary<String, AnyObject>>
        ud.synchronize()
    }
    
    func doesExist() -> Bool {
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
