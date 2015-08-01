//
//  Networking.swift
//  Slipbook
//
//  Created by BenM on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import Foundation

class SBNetworking{
    
    func getResult(urlPath:String) -> NSDictionary {
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
        var error: NSErrorPointer = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request1, returningResponse: response, error:nil)!
        var err: NSError
        println(response)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        println("Synchronous \(jsonResult)")
        return jsonResult
    }
    
}
