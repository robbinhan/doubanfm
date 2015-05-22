//
//  HttpRequest.swift
//  doubanfm
//
//  Created by robbin on 15/5/16.
//  Copyright (c) 2015年 robbin. All rights reserved.
//

import Foundation


class HttpRequest {
    func post(url:String,params:NSDictionary)->NSData{
        
        var body = "";
        var response: NSURLResponse?
        var error: NSError?
        
        for (key,val) in params {
            body += "\(key)=\(val)&"
        }
        
        var httpbody:NSData = (body as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        var req = NSMutableURLRequest(URL: NSURL(string: url)!);
        req.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type");
        req.HTTPMethod = "POST";
        req.HTTPBody = httpbody;
        
        var defaultData:NSData = NSData();
        let urlData = NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: &error)
        if let httpResponse = response as? NSHTTPURLResponse {
            return urlData!;
        }
        return defaultData;
    }
    
    
    func get(url:String)->NSData{
        var defaultData:NSData = NSData();
        
        var response: NSURLResponse?
        var error: NSError?
        
        let urlData = NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: NSURL(string: url)!), returningResponse: &response, error: &error)
        if let httpResponse = response as? NSHTTPURLResponse {
            return urlData!;
        }
                return defaultData;
    }
    
    func asyncGet(url:String)->NSData{
        var defaultData:NSData = NSData();
        println(url);
        //异步获取图片
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string:url)!), queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
                return data;
        })
        return defaultData;
    }
}