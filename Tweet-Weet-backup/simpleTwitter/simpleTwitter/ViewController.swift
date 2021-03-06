//
//  ViewController.swift
//  simpleTwitter
//
//  Created by Ambrish Verma on 2/17/15.
//  Copyright (c) 2015 skylord.co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?) in
            if(user != nil){
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }else{
                // show error
            }
        }
    }
}

