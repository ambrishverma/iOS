//
//  TweetsViewController.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/22/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refreshControl: UIRefreshControl!
    var sTweet: Tweet?
    var tweets = [Tweet]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 177/255, blue: 255/255, alpha: 1.0)
        titleLabel()
        logoutButtonItem()
        newButtonItem()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        refreshControl.addTarget(self, action: "reloadDataFromTwitter", forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.insertSubview(refreshControl, atIndex: 0)
        reloadDataFromTwitter()
        /*
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets 
        })
*/
    }

    func reloadDataFromTwitter(){
        TwitterClient.sharedInstance.getHomeTimeline { (tweets) -> () in
            self.tweets = tweets!
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tweets.count > 0){
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetTableViewCell
        var tweet = self.tweets[indexPath.row]
        cell.userLabel.text = "\(indexPath.row)"
        cell.setTweet(tweet);
        println(indexPath.row)
        return cell
    }
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        tableView.reloadData()
    }
    
    func titleLabel(){
        var titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont(name: "Helvetica Neue", size: 17)
        self.navigationItem.titleView = titleLabel
    }
    
    func newButtonItem(){
        var newTweetButton = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "onNewTweet")
        newTweetButton.tintColor = UIColor.whiteColor()
        newTweetButton . setTitleTextAttributes ([NSFontAttributeName: UIFont (name: "Helvetica Neue" , size: 12)!], forState: UIControlState . Normal)
        self.navigationItem.rightBarButtonItem = newTweetButton
    }
    
    func logoutButtonItem(){
        var logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "onLogout")
        logoutButton.tintColor = UIColor.whiteColor()
        logoutButton.setTitleTextAttributes([NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = logoutButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject){
            User.currentUser?.logout()
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
