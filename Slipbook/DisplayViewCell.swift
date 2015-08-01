//
//  DisplayViewCell.swift
//  Slipbook
//
//  Created by Jon on 26/07/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class DisplayViewCell: UITableViewCell {
    
    
    @IBOutlet var receiptImage: UIImageView!
    @IBOutlet var name: UILabel!
    
    func addCell(nameString: String) {
        name.text = nameString
        receiptImage.hidden = true
        println(nameString)
    }
    
}
