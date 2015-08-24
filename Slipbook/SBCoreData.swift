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
    
    func save(name: String, receiptImage: Array<UIImage>, productImage: Array<UIImage>, dateTaken: NSDate, spent: String, category: String, store: String) {
        
        self.loadAndInsert()
        
        let AD: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = AD.managedObjectContext!
        var newReceipt = NSEntityDescription.insertNewObjectForEntityForName("Receipt", inManagedObjectContext: context) as! NSManagedObject
        
        var imageData: Array<NSData> = []
        
        for i in receiptImage {
            imageData.append(utils.imageToData(i))
        }
        
        var productImageData: Array<NSData> = []
        
        for i in productImage {
            productImageData.append(utils.imageToData(i))
        }
        
        newReceipt.setValue(name, forKey: "name")
        newReceipt.setValue(dateTaken, forKey: "dateTaken")
        newReceipt.setValue(spent, forKey: "spent")
        newReceipt.setValue(category, forKey: "category")
        newReceipt.setValue(imageData, forKey: "receiptImage")
        newReceipt.setValue(store, forKey: "store")
        newReceipt.setValue(productImageData, forKey: "productImage")
        
        context.save(nil)
        
        self.loadAndInsert()
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
                var imageData = result.valueForKey("receiptImage") as! Array<NSData>
                var store = result.valueForKey("store") as! String
                var productImage = result.valueForKey("productImage") as! Array<NSData>
                var dictionary = ["name": name, "spent": spent, "category": category, "dateTaken": dateTaken, "store": store, "receiptImage": imageData, "productImage": productImage]
                array.append(dictionary)
            }
        }
        
        context.save(nil)
        
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
                var imageData = result.valueForKey("receiptImage") as! Array<NSData>
                var store = result.valueForKey("store") as! String
                var productImage = result.valueForKey("productImage") as! Array<NSData>
                var dictionary = ["name": name, "spent": spent, "category": category, "dateTaken": dateTaken, "receiptImage": imageData, "store": store, "productImage": productImage]
                temp.append(dictionary)
            }
        }
        self.receipts = temp
        context.save(nil)
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
    
    func modifyEntry(index: Int, name: String, store: String, category: String, spent: String, productImages: Array<UIImage>, receiptImage: Array<UIImage>) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Receipt")
        request = NSFetchRequest(entityName: "Receipt")
        
        request.returnsObjectsAsFaults = false
        
        if let fetchResults = context.executeFetchRequest(request, error: nil){
            if fetchResults.count != 0 {
                var managedObject = fetchResults[index] as? NSManagedObject
                managedObject!.setValue(name, forKey: "name")
                managedObject!.setValue(store, forKey: "store")
                managedObject!.setValue(category, forKey: "category")
                managedObject!.setValue(spent, forKey: "spent")
                
                var productImageArray: Array<NSData> = []
                var receiptImageArray: Array<NSData> = []
                
                for i in productImages {
                    productImageArray.append(utils.imageToData(i))
                }
                
                for i in receiptImage {
                    receiptImageArray.append(utils.imageToData(i))
                }
                
                managedObject!.setValue(productImageArray, forKey: "productImage")
                managedObject!.setValue(receiptImageArray, forKey: "receiptImage")
                
                context.save(nil)
            }
        }
    }
}
