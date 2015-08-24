//
//  Receipt.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import Foundation
import CoreData

class Receipt: NSManagedObject {

    @NSManaged var category: String
    @NSManaged var dateTaken: NSDate
    @NSManaged var receiptImage: AnyObject
    @NSManaged var name: String
    @NSManaged var spent: String
    @NSManaged var store: String
    @NSManaged var productImage: AnyObject

}
