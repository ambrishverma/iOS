//
//  ViewController.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/21/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if(user != nil) {
                self.performSegueWithIdentifier("loginSegue", sender: self)
                
            } else {
                println("error on login")
            }
        }
        
   }

    
    
}
