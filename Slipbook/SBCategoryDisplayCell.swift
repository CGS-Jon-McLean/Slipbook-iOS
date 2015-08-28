//
//  SBCategoryDisplayCell.swift
//  Slipbook
//
//  Created by Jon on 25/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBCategoryDisplayCell: UITableViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var deleteImage: UIImageView!
    
    func addCell(category: String) {
        categoryLabel.text = category
        deleteImage.image! = deleteImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        deleteImage.tintColor = UIColor.grayColor()
    }
    
}
