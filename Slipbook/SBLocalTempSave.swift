//
//  SBLocalTempSave.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBLocalTempSave {
    
    private var ud = NSUserDefaults.standardUserDefaults()
    private var utils = SBImageToData()
    var dictionary: Dictionary<String, AnyObject> = ["ignore": "11aavvcd"]
    
    func save(name: String?, category: String?, spent: String?, store: String?, productImages: Array<UIImage>?, receiptImages: Array<UIImage>?) {
        //var t: Dictionary<String, AnyObject> = []
        if(name != nil) {
            dictionary.updateValue(name!, forKey: "name")
        }
        
        if(category != nil) {
            dictionary.updateValue(category!, forKey: "category")
        }
        
        if(spent != nil) {
            dictionary.updateValue(spent!, forKey: "spent")
        }
        
        if(store != nil) {
            dictionary.updateValue(store!, forKey: "store")
        }
        
        if(productImages != nil) {
            var imageData: Array<NSData> = []
            for i in productImages! {
                imageData.append(utils.imageToData(i))
            }
            dictionary.updateValue(imageData, forKey: "productImages")
        }
        
        if(receiptImages != nil) {
            var imageData: Array<NSData> = []
            for i in receiptImages! {
                imageData.append(utils.imageToData(i))
            }
            dictionary.updateValue(imageData, forKey: "receiptImages")
        }
        
        ud.setValue(dictionary, forKey: "cache")
    }
    
    func load() {
        dictionary = ud.valueForKey("cache") as! Dictionary<String, AnyObject>
    }
    
    func doesExist() -> Bool {
        return ud.valueForKey("cache") != nil ? true : false
    }
    
    func getValuesKeys() -> Array<String>{
        var array: Array<String> = []
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
}
