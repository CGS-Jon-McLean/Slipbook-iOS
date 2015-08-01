//
//  Search.swift
//  Slipbook
//
//  Created by BenM on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import Foundation

class Search{
    func searchDictionary(searchArray:Array<Dictionary<String, AnyObject>>, keys:Array<String>, queryString:String) -> Array<Dictionary<String, AnyObject>>?{
        
        var returnArray:Array<Dictionary<String, AnyObject>> = []
        let query=queryString.lowercaseString
        
        for(var i=0;i<searchArray.count;i++){
            for(var x=0;x<keys.count;x++){
                let current: String=(searchArray[i][keys[x]] as String).lowercaseString
                if(current==query){
                    returnArray.append(searchArray[i])
                    i=searchArray.count
                }
            }
        }
        
        return returnArray
    }
}