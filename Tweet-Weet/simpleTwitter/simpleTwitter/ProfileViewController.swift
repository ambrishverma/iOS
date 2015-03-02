//
//  ProfileViewController.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/28/15.
//  Copyright (c) 2015 skylord.co. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userHandleLabel: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 177/255, blue: 255/255, alpha: 1.0)
        setCancelButton()

//        self.userProfileImage.layer.cornerRadius = 5
        self.userImage.clipsToBounds = true
//        self.userBackImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileBackImage)!))
        self.userImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileImageUrl)!))
        self.userNameLabel.text = User.CurrentUser!.name
        self.userHandleLabel.text = "@\(User.CurrentUser!.screenName)"
        self.tweetCountLabel.text = "\(User.CurrentUser!.tweetCount)"
        self.followersCountLabel.text = "\(User.CurrentUser!.followerCount)"
        self.followingCountLabel.text = "\(User.CurrentUser!.followingCount)"
        
        TwitterClient.sharedInstance.homeTimeline { (tweets) -> () in
            self.tweets = tweets!
            self.tableView.reloadData()
        }


        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 110
        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)

    }

    func setCancelButton(){
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "onCancel")
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 12)!], forState: UIControlState.Normal)
        cancelButton.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func onCancel(){
        dismissViewControllerAnimated(true, completion: nil)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("profileCell") as ProfileTableViewCell
        cell.setCells(tweets[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @IBAction func OnPanGesture(sender: UIPanGestureRecognizer) {
        var lTR = sender.velocityInView(view).x > 0
        if(lTR){
            pageControl.currentPage = 1
            self.userNameLabel.text = "\(User.CurrentUser!.name) : Mentions"
            self.userHandleLabel.text = "@\(User.CurrentUser!.screenName)"
            
        }else{
            pageControl.currentPage = 0
            self.userNameLabel.text = "\(User.CurrentUser!.name)"
            self.userHandleLabel.text = "@\(User.CurrentUser!.screenName)"
        }
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
