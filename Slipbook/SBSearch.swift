//
//  Search.swift
//  Slipbook
//
//  Created by BenM on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import Foundation

class SBSearch{
    static func searchDictionary(searchArray:Array<Dictionary<String, AnyObject>>, keys:Array<String>, queryString:String) -> Array<Dictionary<String, AnyObject>>?{
        
        var returnArray:Array<Dictionary<String, AnyObject>> = []
        let query=split(queryString.lowercaseString){$0 == " "}
        
        for(var i=0;i<searchArray.count;i++){
            for(var x=0;x<keys.count;x++){
                var current=split((searchArray[i][keys[x]] as! String).lowercaseString){$0 == " "}
                var queryFound=true;
                for(var y=0;y<query.count;y++){
                    var queryFoundLocal=false
                    for(var z=0;z<current.count;z++){
                        if(current[z].rangeOfString(query[y]) != nil){
                            queryFoundLocal=true
                      
                        }
                    }
                    if(!queryFoundLocal){
                        queryFound=false
                        y=query.count
                    }
                }
                if(queryFound){
                    returnArray.append(searchArray[i]);
                    x=keys.count
                }
            }
        }
        
        return returnArray
    }
}