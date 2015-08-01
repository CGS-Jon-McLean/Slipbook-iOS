//
//  ImageUtils.swift
//  Slipbook
//
//  Created by Jon on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class ImageToData {
    
    func imageToData(imageToConvert: UIImage) -> NSData {
        var compQuality: CGFloat = 0.8
        var data: NSData = UIImageJPEGRepresentation(imageToConvert, compQuality)
        
        return data
    }
    
    func dataToImage(dataToConvert: NSData) -> UIImage {
        var image: UIImage = UIImage(data: dataToConvert)!
        return image
    }
}

