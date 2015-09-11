//
//  SBReceiptImageCell.swift
//  Slipbook
//
//  Created by Jon on 9/09/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBReceiptImageCell: UITableViewCell {
    
    @IBOutlet var receiptImage: UIImageView!
    
    func addCell(image: UIImage) {
        receiptImage.image = image
    }
    
}
