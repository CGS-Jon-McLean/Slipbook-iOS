//
//  StoreDisplayCell.swift
//  Slipbook
//
//  Created by Jon on 16/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBStoreDisplayCell: UITableViewCell {
    
    @IBOutlet var storeLabel: UILabel!
    @IBOutlet var deleteImage: UIImageView!
    
    
    func addCell(store: String) {
        storeLabel.text = store
        deleteImage.image! = deleteImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        deleteImage.tintColor = UIColor.grayColor()
    }
    
    

}
