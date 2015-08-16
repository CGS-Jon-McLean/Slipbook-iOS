//
//  SBCoreData.swift
//  Slipbook
//
//  Created by Jon on 14/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit
import CoreData

class SBCoreData {
    
    private var utils = SBImageToData()
    
    var receipts: Array<Dictionary<String, AnyObject>> = []
    
    func save(name: String, image: UIImage, dateTaken: NSDate, spent: String, category: String, store: String) {
        
        let AD: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = AD.managedObjectContext!
        var newReceipt = NSEntityDescription.insertNewObjectForEntityForName("Receipt", inManagedObjectContext: context) as! NSManagedObject
        
        var imageData = utils.imageToData(image)
        
        newReceipt.setValue(name, forKey: "name")
        newReceipt.setValue(dateTaken, forKey: "dateTaken")
        newReceipt.setValue(spent, forKey: "spent")
        newReceipt.setValue(category, forKey: "category")
        newReceipt.setValue(imageData, forKey: "image")
        newReceipt.setValue(store, forKey: "store")
    }
    
    func loadAndReturn() -> Array<Dictionary<String, AnyObject>> {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Receipt")
        request = NSFetchRequest(entityName: "Receipt")
        
        request.returnsObjectsAsFaults = false
        
        var error: NSError?
        
        var results = context.executeFetchRequest(request, error: &error)
        
        if(error != nil) {
            println("An error occured while fetching the results from the Core Data Model.")
        }
        
        var array: Array<Dictionary<String, AnyObject>> = []
        
        if results!.count > 0 {
            
            for result: AnyObject in results as! [NSManagedObject] {
                var name = result.valueForKey("name") as! String
                var spent = result.valueForKey("spent") as! String
                var category = result.valueForKey("category") as! String
                var dateTaken = result.valueForKey("dateTaken") as! NSDate
                var imageData = result.valueForKey("image") as! NSData
                var store = result.valueForKey("store") as! String
                var dictionary = ["name": name, "spent": spent, "category": category, "dateTaken": dateTaken, "image": imageData, "store": store]
                array.append(dictionary)
            }
        }
        return array
    }
    
    func loadAndInsert() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Receipt")
        request = NSFetchRequest(entityName: "Receipt")
        
        request.returnsObjectsAsFaults = false
        
        var error: NSError?
        
        var results = context.executeFetchRequest(request, error: &error)
        
        if error != nil {
            println("An error occured while fetching the results from the Core Data Model.")
        }
        
        var temp: Array<Dictionary<String, AnyObject>> = []
        
        if results!.count > 0 {
            
            for result: AnyObject in results as! [NSManagedObject] {
                
                var name = result.valueForKey("name") as! String
                var spent = result.valueForKey("spent") as! String
                var category = result.valueForKey("category") as! String
                var dateTaken = result.valueForKey("dateTaken") as! NSDate
                var imageData = result.valueForKey("image") as! NSData
                var store = result.valueForKey("store") as! String
                var dictionary = ["name": name, "spent": spent, "category": category, "dateTaken": dateTaken, "image": imageData, "store": store]
                temp.append(dictionary)
            }
        }
        self.receipts = temp
    }
    
    func countElements() -> Int {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Receipt")
        request = NSFetchRequest(entityName: "Receipt")
        
        request.returnsObjectsAsFaults = false
        
        var error: NSError?
        
        var results = context.executeFetchRequest(request, error: &error)
        
        if(error != nil) {
            println("An error occured while fetching the results from the Core Data Model.")
        }
        
        if(results == nil) {
            return 0
        }
        
        return results!.count
    }
}
