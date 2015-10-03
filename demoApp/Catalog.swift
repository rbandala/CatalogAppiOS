//
//  Catalog.swift
//  demoApp
//
//  Created by IAA-ACS-2 on 9/14/15.
//  Copyright (c) 2015 Rajesh. All rights reserved.
//

import Foundation

class Catalog {
    var id : String = ""
    var products = [Product]()
    
    init(json: NSDictionary) {
        self.id = (json["Id"] as? String)!
        //self.products = (json["Productlist"] as? [Product])!
        
        var items = json["ProductList"] as! NSArray
        
        
        for item in items
        {
            
            var product = Product(json: item as! NSDictionary)
            self.products.append(product)
            
            
        }
    }
}