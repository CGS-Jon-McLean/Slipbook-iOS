//
//  SBLocalSortCache.swift
//  Slipbook
//
//  Created by Jon on 25/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBLocalSortCache {
    
    private var ud = NSUserDefaults.standardUserDefaults()
    var cache: String = ""
    var cat: Bool = false
    var sort: Bool = false
    
    func addVariable(string: String, cat: Bool, sort: Bool,  confirm: Bool) {
        if(confirm) {
            self.cache = string
            self.sort = sort
            self.save()
            println("Cache: " + cache)
        }else {
            // do nothing
        }
    }
    
    private func save() {
        println("Saved")
        ud.setValue(cache, forKey: "sort_cache")
        ud.setValue(cat, forKey: "sort_cache_category")
        ud.setValue(sort, forKey: "sort_cache_sort")
        ud.synchronize()
    }
    
    init() {
        if(ud.valueForKey("sort_cache") != nil) {
            cache = ud.valueForKey("sort_cache") as! String
            cat = ud.valueForKey("sort_cache_category") as! Bool
            sort = ud.valueForKey("sort_cache_sort") as! Bool
        }else { }
    }
    
    func removeCaches() {
        ud.removeObjectForKey("sort_cache")
        ud.removeObjectForKey("sort_cache_category")
        ud.removeObjectForKey("sort_cache_sort")
    }
    
}
