//
//  MainViewController.swift
//  demoApp
//
//  Created by IAA-ACS-2 on 9/14/15.
//  Copyright (c) 2015 Rajesh. All rights reserved.
//

import UIKit

class MainViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var tblProducts: UICollectionView!
    @IBOutlet weak var lblFilter: UILabel!
    
    var repositories = [Catalog]()
    var filteredProducts = [Product]()
    /**
    static header fileds and values
    */
    var headerFieldAndValues : NSDictionary!
    /**
    SSHTTPClient instance to use with each service call.
    */
    private var httpClient : SSHTTPClient?
    
    enum httpMethods : String {
        case Get = "GET"
        case Post = "POST"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblProducts.dataSource = self
        self.tblProducts.delegate = self
        loadDataSource()
        
        
    }
    /*func tblProducts(collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
          }
    func tblProducts(collectionView: UICollectionView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    }*/

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  filteredProducts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return populateFieldTableViewCellforIndexPath(indexPath)
    }
    
    

    
    //func tblProducts(collectionView: UICollectionView, numver
    func loadDataSource(){
        let urlString = "http://fresheshop.azurewebsites.net/service.svc/GetCityBasedCatalog/CityCode/CHNI/?SupplierID=CHN001"
        httpClient = SSHTTPClient(url: urlString, method: httpMethods.Get.rawValue, httpBody: nil, headerFieldsAndValues: nil)
        httpClient?.getJsonData({ (obj, error) -> Void in
            if error == nil {
                var data = obj as! NSDictionary
                var arrData = data["CatalogList"] as! NSArray!
                //var err : NSError?
                //var jsonArray = NSJSONSerialization.JSONObjectWithData(arrData as! NSData, options: NSJSONReadingOptions.AllowFragments, error: &err) as! NSArray
                //self.repositories = arrData as! [Catalog]
                //self.filteredProducts =  (self.repositories.first!).products
                for item in arrData
                {
                    
                    var catalog = Catalog(json: item as! NSDictionary)
                    self.repositories.append(catalog)
                    
                    
                }
                if( self.repositories.count > 1){
                self.filteredProducts = self.repositories[0].products
                self.tblProducts.reloadData()
                }
                
                
            }
        })
        
    }
    
    func populateFieldTableViewCellforIndexPath(indexPath : NSIndexPath) -> UICollectionViewCell{

        let cell = tblProducts.dequeueReusableCellWithReuseIdentifier("MainCollectionViewCell", forIndexPath: indexPath) as! MainCollectionViewCell
        let product = self.filteredProducts[indexPath.row]
        
        cell.lblProductName.text = product.name
        cell.lblCostPrice.text = product.costprice
        cell.lblSellingPrice.text = product.sellingPrice
        cell.setAvailability(product.available)
        
        return cell
    }
}