//
//  Api.swift
//  doubanfm
//
//  Created by robbin on 15/5/16.
//  Copyright (c) 2015年 robbin. All rights reserved.
//

import Foundation

class Api{
    
    var captcha_id:String;
    
    init(){
        self.captcha_id = ""
    }
    
    func login(email:String,password:String,captcha_solution:String)->Bool{
            var url = "http://douban.fm/j/login";
            var params = ["remember":"off","source":"radio","captcha_solution":captcha_solution,"alias":email,"form_password":password,"captcha_id":self.captcha_id];
            var http = HttpRequest();
            var data = http.post(url,params: params);
        

        println(url);
        println(params);
        println(NSString (data: data, encoding: NSUTF8StringEncoding));
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.AllowFragments,
            error:&parseError)
        
        //2
        if let body_dic = parsedObject as? NSDictionary {
             if let r = body_dic["r"] as? Int {
                if r == 0 {
                    if let user_info = body_dic["user_info"] as? NSDictionary {
                        if let id:AnyObject = user_info["id"] {
                            println("id:\(id)");
                            NSUserDefaults.standardUserDefaults().setObject(id, forKey: "user_id");
                            NSUserDefaults.standardUserDefaults().synchronize()
                            return true;
                        }
                    }
                }
            }
        }
        
        return false;
        
    }
    
    
    func newCaptcha() -> NSData {
        var http = HttpRequest();
        
        //获取captcha id
        var url = "http://douban.fm/j/new_captcha";
        var urlData = http.get(url);
        var captcha_id  = NSString(data: urlData, encoding: NSUTF8StringEncoding) as! String;
        
        //获取captch image
        self.captcha_id = captcha_id.stringByReplacingOccurrencesOfString("\"",withString: "")
        url = "http://douban.fm/misc/captcha?size=m&id=\(self.captcha_id)"
        var data:NSData = http.get(url)
        return data;
    }
    
    func favoriteList()->NSArray{
        var result = [];
        var http = HttpRequest();
        var url = "http://douban.fm/j/mine/playlist?from=mainsite&channel=-3&kbps=64&h=&sid=&type=n&r=927c04500d89d"
        var data = http.get(url);
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.AllowFragments,
                error:&parseError)
        
        if let body_dic = parsedObject as? NSDictionary {
                if let r = body_dic["r"] as? Int {
                    if r == 0 {
                        if let songs = body_dic["song"] as? NSArray {
                            return songs;
                        }
                    }
                }
        }
        return result;
    }
}
