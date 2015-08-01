//
//  SBTempFieldSave.swift
//  Slipbook
//
//  Created by Jon on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBTempFieldSave {
    
    private var ud = NSUserDefaults.standardUserDefaults()
    
    func set(dict: Dictionary<String, AnyObject>) {
        ud.setValue(dict, forKey: "temp-dict-save")
    }
    
    func get() -> Dictionary<String, AnyObject> {
        return ud.valueForKey("temp-dict-save") as! Dictionary<String, AnyObject>
    }
    
    func doesExist() -> Bool {
        return ud.valueForKey("temp-dict-save") != nil ? true : false
    }
    
}