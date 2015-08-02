//
//  SBDetailViewController.swift
//  Slipbook
//
//  Created by Jon on 1/08/2015.
//  Copyright (c) 2015 Actro. All rights reserved.
//

import UIKit

class SBDetailViewController: UIViewController {
    
    var index: Int = 1
    
    var local = SBReceiptLocalManager()
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        local.load()
        println(index)
        fill()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fill() {
        var dict = local.get(index)
        var name = dict["name"] as! String
        println("Name: \(name)")
        
        var imageData = dict["image"] as! NSData
        var image = UIImage(data: imageData)
        //println(imageData)
        imageView.image = image
    }

    @IBAction func menuButton(sender: AnyObject) {
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
