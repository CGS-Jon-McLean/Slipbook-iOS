//
//  Receipt.swift
//  Slipbook
//
//  Created by Jon on 15/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import Foundation
import CoreData

class Receipt: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var image: AnyObject
    @NSManaged var dateTaken: NSDate
    @NSManaged var spent: String
    @NSManaged var category: String

}
