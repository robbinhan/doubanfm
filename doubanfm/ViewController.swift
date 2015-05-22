//
//  ViewController.swift
//  doubanfm
//
//  Created by robbin on 15/5/16.
//  Copyright (c) 2015年 robbin. All rights reserved.
//

import UIKit

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
        var ret:Bool = api.login(email.text!, password: password.text!,captcha_solution:captchaText.text!);
        
    }


}

