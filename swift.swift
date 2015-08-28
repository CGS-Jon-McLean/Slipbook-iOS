//
//  swift.swift
//  Slipbook
//
//  Created by Jon on 28/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import Foundation
import CoreData

@objc(swift)
class swift: NSManagedObject {

    @NSManaged var category: String
    @NSManaged var dateTaken: NSDate
    @NSManaged var name: String
    @NSManaged var productImage: AnyObject
    @NSManaged var receiptImage: AnyObject
    @NSManaged var spent: String
    @NSManaged var store: String

}
