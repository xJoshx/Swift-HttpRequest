//
//  HttpRequest.swift
//  
//
//  Created by Jose Vizcaino on 22/8/15.
//
//

import Foundation
import UIKit

/**
    This Class handles the http requests
*/
//TODO: Error Management

class HttpRequest {
    var url : String = ""
    var json : NSDictionary = NSDictionary()
    
    func start() {
        self.performRequest()
    }
    
    //
    //  Perform an http request
    //
    
    func performRequest() {
        let request : NSURLRequest = self.createRequest()
        let queue : NSOperationQueue = self.createQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            if((error) != nil){
                println("An error ocurred \(error)")
            } else {
                
                self.json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                
                self.test()
                
            }
        })
    }
    
    //
    // Create a simple NSURLRequest using a NSURL
    //
    
    func createRequest() -> NSURLRequest{
        let url = createUrl()
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        return request
    }
    
    func createUrl() -> NSURL{
        let url : NSURL = NSURL(string: self.url)!
        return url
    }
    
    //
    //  Set the URL
    //
    
    func setUrl(url : String){
        self.url = url
    }
    
    //
    //  Check if is a valid URL
    //
    
    func verifyUrl (url: String?) -> Bool {
        //Check for nil
        if let urlString = url {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        return false
    }
    
    //
    //  Create a NSOperationQueue
    //
    
    func createQueue() -> NSOperationQueue{
        let queue:NSOperationQueue = NSOperationQueue()
        return queue
    }
    
    //
    //  Init with an URL
    //
    
    init(url : String) {
        self.setUrl(url)
    }
    
    //
    //  To test the result
    //
    
    func test() {
        println(self.json)
    }
}