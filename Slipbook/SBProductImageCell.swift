//
//  SBImageCell.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBProductImageCell: UITableViewCell {
    
    @IBOutlet var receiptProductImageView: UIImageView!
    
    func addCell(image: UIImage) {
        self.receiptProductImageView.image = image
    }
    
}
