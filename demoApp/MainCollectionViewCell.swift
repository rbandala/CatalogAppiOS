//
//  MainCollectionViewCell.swift
//  demoApp
//
//  Created by IAA-ACS-2 on 9/14/15.
//  Copyright (c) 2015 Rajesh. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblProductName: UILabel!
   
    @IBOutlet weak var lblCostPrice: UILabel!
    
    @IBOutlet weak var lblSellingPrice: UILabel!
    
    @IBOutlet weak var lblAvailable: UILabel!
    
    func setAvailability(isAvailable : String) {
        if(isAvailable == "True"){
            lblAvailable.text = "Yes"
            lblAvailable.textColor = UIColor.greenColor()
        }
        else
        {
            lblAvailable.text = "False"
            lblAvailable.textColor = UIColor.redColor()
        }
    }
}

