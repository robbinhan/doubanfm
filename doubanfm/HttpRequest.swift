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
            //获取cookie方法3
            var cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage();
            for cookie in cookieJar.cookies! {
                println(cookie.name)
                var value: AnyObject = cookie.valueForKey("value")!;
                value = value.stringByReplacingOccurrencesOfString("\"", withString: "");
                println(value);
                
                //设置存储信息
                NSUserDefaults.standardUserDefaults().setObject(value, forKey: cookie.name)
                NSUserDefaults.standardUserDefaults().synchronize();
            }
            return urlData!;
            
        }
        return defaultData;
    }
    
    
    func get(url:String)->NSData{
        var defaultData:NSData = NSData();
        
        var response: NSURLResponse?
        var error: NSError?
        
        
        var req = NSMutableURLRequest(URL: NSURL(string: url)!);
        
        var dbcl2 = NSUserDefaults.standardUserDefaults().valueForKey("dbcl2") as! String!;
        var bid = NSUserDefaults.standardUserDefaults().valueForKey("bid") as! String!;
        var fmNlogin = NSUserDefaults.standardUserDefaults().valueForKey("fmNlogin") as! String!;
        
        if let login = fmNlogin {
            if login == "y" {
                req.addValue("bid=\(bid);dbcl2=\(dbcl2);fmNlogin=\(fmNlogin)",forHTTPHeaderField: "Cookie");
            }
        }
        
        let urlData = NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: &error)
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