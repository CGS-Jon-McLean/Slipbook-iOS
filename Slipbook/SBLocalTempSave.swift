//
//  SBLocalTempSave.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBLocalTempSave {
    
    var ud = NSUserDefaults.standardUserDefaults()
    var utils = SBImageToData()
    var dictionary: Dictionary<String, AnyObject> = ["ignore": "11aavvcd"]
    
    func save(name: String?, category: String?, spent: String?, store: String?, productImages: Array<UIImage>?, receiptImages: Array<UIImage>?) {
        //var t: Dictionary<String, AnyObject> = []
        if(name != nil) {
            dictionary.updateValue(name!, forKey: "name")
            println("N")
        }
        
        if(category != nil) {
            dictionary.updateValue(category!, forKey: "category")
            println("C")
        }
        
        if(spent != nil) {
            dictionary.updateValue(spent!, forKey: "spent")
            println("Sp")
        }
        
        if(store != nil) {
            dictionary.updateValue(store!, forKey: "store")
            println("St")
        }
        
        if(productImages != nil) {
            var imageData: Array<NSData> = []
            for i in productImages! {
                imageData.append(utils.imageToData(i))
                println("PI")
            }
            dictionary.updateValue(imageData, forKey: "productImages")
        }
        
        if(receiptImages != nil) {
            var imageData: Array<NSData> = []
            for i in receiptImages! {
                imageData.append(utils.imageToData(i))
                println("RI")
            }
            dictionary.updateValue(imageData, forKey: "receiptImages")
        }
        
        ud.setValue(dictionary, forKey: "cache")
        println("Sv")
        ud.synchronize()
        println("Sync")
        
        //println("Cache thing: \(dictionary)")
    }
    
    func load() {
        dictionary = ud.valueForKey("cache") as! Dictionary<String, AnyObject>
        println("Load Function")
        //println(dictionary)
        println("Finish printing dictionary")
    }
    
    func doesExist() -> Bool {
        println("doesExist Function")
        return ud.valueForKey("cache") != nil ? true : false
    }
    
    func getValuesKeys() -> Array<String>{
        var array: Array<String> = []
        println("getValuesKeys Function: Start")
        if(dictionary["name"] != nil) {
            array.append("name")
        }
        
        if(dictionary["category"] != nil) {
            array.append("category")
        }
        
        if(dictionary["spent"] != nil) {
            array.append("spent")
        }
        
        if(dictionary["store"] != nil) {
            array.append("store")
        }
        
        if(dictionary["productImages"] != nil) {
            array.append("productImages")
        }
        
        if(dictionary["receiptImages"] != nil) {
            array.append("receiptImages")
        }
        
        return array
    }
    
    func removeCaches() {
        ud.removeObjectForKey("cache")
    }
}
