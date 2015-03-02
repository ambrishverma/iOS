//
//  MenuViewController.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/26/15.
//  Copyright (c) 2015 skylord.co. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class{
    
    func menuSelected(menu:String)
    
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var refreshControl: UIRefreshControl!
    
    var delegate: MenuViewControllerDelegate?

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var profileHandle: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuItems: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        
        populateProfile()
        populateMenu()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //titleLabel()
        //logoutButtonItem()
        //menuButtonItem()
//        self.tableView.rowHeight = 200
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        
       tableView.reloadData()
       tableView.tableFooterView = UIView(frame: CGRectZero)
       

    }
    
    func populateProfile() {
        profileImage.setImageWithURL(NSURL(string: User.CurrentUser!.profileImageUrl))
        profileImage.layer.cornerRadius = 5
        profileImage.clipsToBounds = true
        
        userName.text = User.CurrentUser?.name
        profileHandle.text = User.CurrentUser!.screenName
    
    }
    
    func populateMenu() {
        menuItems = [String]()
//        var homeMenu = MenuItem(_name: "Me", _icon:  UIImage(named: "birds6")!)
//        var timeline = MenuItem(_item: "Timeline", _icon:  UIImage(named: "AppIcon")!)
//        var mentions = MenuItem(_item: "Mentions", _icon:  UIImage(named: "AppIcon")!)
//        var logout = MenuItem(_item: "Logout", _icon: UIImage(named: "AppIcon")!)
        
        menuItems.append("Profile")
        menuItems.append("Timeline")
        menuItems.append("Mentions")
        menuItems.append("Logout")

    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as MenuTableViewCell
        //cell.te = indexPath.row
        //cell.menuItemImage.image = menuItems[indexPath.row].menuIcon
        cell.menuItem.text = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.menuSelected(menuItems[indexPath.row])
    }
    
    @IBAction func onTap(sender: AnyObject) {
        self.delegate?.menuSelected("Me")
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
