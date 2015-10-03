//
//  SSHTTPClient.swift
//  demoApp
//
//  Created by IAA-ACS-2 on 9/14/15.
//  Copyright (c) 2015 Rajesh. All rights reserved.
//

import Foundation
public typealias SSHTTPResponseHandler = (obj : AnyObject? , error : NSError?) -> Void

/**
A model Class for triggering HTTP service calls.
*/

public class SSHTTPClient : NSObject {
    var httpMethod,urlStr,httpBody: NSString?
    var headerFieldsAndValues : NSDictionary?
    /**
    inititilizer method with url,method,httpbody and headerFiledsAndValues paramter
    */
    
    public init(url:NSString, method:NSString, httpBody: NSString?, headerFieldsAndValues: NSDictionary?  ) {
        self.urlStr =  url;
        self.httpMethod = method;
        self.httpBody = httpBody;
        self.headerFieldsAndValues = headerFieldsAndValues
    }
    
    /**
    Calls the Webservice via NSURLSession in the background. Accepts a Response Handler(Closure). It returns response object as JSON and also return if any error to handler.
    */
    public func getJsonData(httpResponseHandler : SSHTTPResponseHandler) {
        var request = NSMutableURLRequest(URL: NSURL(string:self.urlStr! as String)!)
        request.HTTPMethod =  self.httpMethod! as String
        self.headerFieldsAndValues?.enumerateKeysAndObjectsUsingBlock({ (key, value, stop) -> Void in
            request.setValue(value as! NSString as String, forHTTPHeaderField: key as! NSString as String)
        })
        request.HTTPBody = self.httpBody?.dataUsingEncoding(NSUTF8StringEncoding)
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response , error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                println("HTTP STATUS CODE: \(httpResponse.statusCode) for URL \(httpResponse.URL?.absoluteString)")
                
                if httpResponse.statusCode == 200 {
                    
                    if (error == nil) {
                        var jsonError : NSError?
                        var json : AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &jsonError)
                        
                        if jsonError == nil {
                            if let object = json as? Array <AnyObject> {
                                httpResponseHandler(obj: object ,error: nil)
                            }else if let object = json as? Dictionary <String, AnyObject> {
                                httpResponseHandler(obj: object ,error: nil)
                            }else {
                                httpResponseHandler(obj: nil,error:jsonError)
                            }
                        }
                        else {
                            httpResponseHandler(obj: NSString(data: data, encoding: NSUTF8StringEncoding) ,error: nil)
                        }
                        
                    }else {
                        httpResponseHandler(obj: nil,error: error)
                    }
                }
                else {
                    println(NSString(data: data, encoding: NSUTF8StringEncoding))
                    var error = NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)
                    httpResponseHandler(obj: nil,error: error)
                }
            }
        })
        task.resume()
    }
    /**
    Calls the Webservice via NSURLSession in the background. Accepts a Response Handler(Closure). it returns response data and also return if any error to handler.
    */
    func getResponseData(urlString :NSString?,httpResponseHandler : SSHTTPResponseHandler) {
        var request = NSMutableURLRequest(URL: NSURL(string:self.urlStr! as String)!)
        request.HTTPMethod =  self.httpMethod! as String
        self.headerFieldsAndValues?.enumerateKeysAndObjectsUsingBlock({ (key, value, stop) -> Void in
            request.setValue(value as? String, forHTTPHeaderField: key as! NSString as String)
        })
        request.HTTPBody = self.httpBody?.dataUsingEncoding(NSUTF8StringEncoding)
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response , error) -> Void in
            if (error == nil) {
                httpResponseHandler (obj: data, error: nil)
            }else {
                httpResponseHandler(obj: nil,error: error)
            }
        })
        task.resume()
    }
    /**
    This method finished any NSRLSession based call
    */
    func finishRequest()->Void{
        var session = NSURLSession.sharedSession()
        session.invalidateAndCancel()
    }
    
    public func getStringData(httpResponseHandler : SSHTTPResponseHandler) {
        var request = NSMutableURLRequest(URL: NSURL(string:self.urlStr! as String)!)
        request.HTTPMethod =  self.httpMethod! as String
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: { (data, response , error) -> Void in
            if (error == nil) {
                var shouldSync = NSString(data: data, encoding: NSUTF8StringEncoding)?.boolValue
                
                httpResponseHandler(obj: shouldSync,error: error)
            }
        })
        task.resume()
    }
    
    
}
