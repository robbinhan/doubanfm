//
//  ViewController.swift
//  doubanfm
//
//  Created by robbin on 15/5/16.
//  Copyright (c) 2015年 robbin. All rights reserved.
//

import UIKit;
import AVFoundation;


class ViewController: UIViewController {
    
    @IBOutlet var email:UITextField!
    @IBOutlet var password:UITextField!
    @IBOutlet var loginButton:UIButton!
    @IBOutlet var captchaImageView:UIImageView!
    @IBOutlet var captchaText:UITextField!
    
    var api = Api()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var nsd:NSData = api.newCaptcha();
        var img = UIImage(data:nsd);
        self.captchaImageView.image = img;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func login(sender:UIButton){
        var user_id = NSUserDefaults.standardUserDefaults().valueForKey("user_id") as! String!
        
        if let id = user_id {
            println("logined")
            var dbcl2 = NSUserDefaults.standardUserDefaults().valueForKey("dbcl2") as! String!;
            println(dbcl2);
        } else {
            var ret:Bool = api.login(email.text!, password: password.text!,captcha_solution:captchaText.text!);
            println("else logined")
            var dbcl2 = NSUserDefaults.standardUserDefaults().valueForKey("dbcl2") as! String!;
            println(dbcl2);
            
            var data:NSArray = api.favoriteList();
            
            var song_info = data.firstObject as? NSDictionary;
            
            println(song_info)
            var url = song_info?.valueForKey("url") as! String!;
            println(url)
            var steamingURL:NSURL = NSURL(string:url)!
            var player = AVPlayer(URL: steamingURL)
            println(player.volume)
                        println(player.status)
                                    println(player.error)
            player.play()
                                                println(player.status)
                                                println(player.error)
        }
    }


}

