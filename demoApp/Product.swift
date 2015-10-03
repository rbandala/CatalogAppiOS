//
//  Product.swift
//  demoApp
//
//  Created by IAA-ACS-2 on 9/14/15.
//  Copyright (c) 2015 Rajesh. All rights reserved.
//

import Foundation

class Product {
    var id : String = ""
    var name : String = ""
    var costprice : String = ""
    var sellingPrice : String = ""
    var available : String = ""
    
    init(json: NSDictionary) {
        self.id = (json["Id"] as? String)!
        self.name = (json["Name"] as? String)!
        self.costprice = (json["CostPrice"] as? String)!
        self.sellingPrice = (json["SellingPrice"] as? String)!
        self.available = (json["Available"] as? String)!
            
           /*{
            get{
                if((json["Available"] as? String) == "yes")
                {
                    return true
                }
                else{
                    return false
                }
            }
            
            set{
                
            }*/
    }
    
}
