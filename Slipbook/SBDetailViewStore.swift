//
//  SBDetailViewStore.swift
//  Slipbook
//
//  Created by Jon on 9/09/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBDetailViewStore {
    
    private var ud = NSUserDefaults.standardUserDefaults()
    var object: AnyObject = ""
    var isIndex = false
    
    func addObject(objectParam: AnyObject, isIndexParam: Bool) {
        //self.saveToDefault()
        self.object = objectParam
        isIndex = isIndexParam
        self.saveToDefault()
    }
    
    private func saveToDefault() {
        self.ud.setValue(object, forKey: "object_save_detail")
        self.ud.setValue(isIndex, forKey: "index_save_detail")
        ud.synchronize()
    }
    
    init() {
        if(self.ud.valueForKey("object_save_detail") != nil) {
            object = self.ud.valueForKey("object_save_detail")!
            isIndex = self.ud.valueForKey("index_save_detail") as! Bool
        }else {
            println("No cache. Ignoring")
        }
    }
    
}
