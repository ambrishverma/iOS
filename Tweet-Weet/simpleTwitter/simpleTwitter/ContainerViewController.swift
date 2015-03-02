//
//  ContainerViewController.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/28/15.
//  Copyright (c) 2015 skylord.co. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UIGestureRecognizerDelegate,TweetsViewControllerDelegate, MenuViewControllerDelegate {
  
    var tweetsViewCtr: TweetsViewController?

    var menuViewCtr: MenuViewController?
    
    var navCtr: UINavigationController?

    var mainSb = UIStoryboard(name: "Main", bundle: nil)
    
    enum MenuState{
        case Open, Closed
    }
    
    var currentMenuState: MenuState?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tweetsViewCtr = mainSb.instantiateViewControllerWithIdentifier("tweetsVC") as? TweetsViewController
        tweetsViewCtr?.delegate = self
        currentMenuState = MenuState.Closed
        
        navCtr = UINavigationController(rootViewController: tweetsViewCtr!)
        
        view.addSubview(navCtr!.view!)
        addChildViewController(navCtr!)
        navCtr!.didMoveToParentViewController(self)
        

        var panGesture = UIPanGestureRecognizer(target: self, action: "onPanGesture:")
        navCtr?.view.addGestureRecognizer(panGesture)
        
    }
    
    func toggleMenu() {
        println("toggle menu")
    }
    
    func onPanGesture (sender: UIPanGestureRecognizer) {
        println("on pan gesture")
 /*
        if (currentMenuState == MenuState.Closed) {
            println("add menu")
            addMenu()
        } else {
            println("remove menu")
            removeMenu()
        }
   */
        var lTRGesture = sender.velocityInView(view).x > 0
        
        switch(sender.state){
            
        case .Began:
            if(currentMenuState == MenuState.Closed){
                if(lTRGesture){
                    addMenu()
                }
            } else {
                removeMenu()
            }
        case .Changed:
            sender.view!.center.x = sender.view!.center.x + sender.translationInView(view).x
            sender.setTranslation(CGPointZero, inView: view)
            
        case .Ended:
            if(menuViewCtr != nil){
                var movedMoreThanHalf = sender.view!.center.x > view.bounds.size.width
                AnimateMenu(movedMoreThanHalf)
            }else{
                animateMenuBar(0, completion: nil)
                
            }
        default: break
        }
        
    }
    
    func addMenu() {
        println("adding menu")
        if (menuViewCtr == nil) {
            menuViewCtr = mainSb.instantiateViewControllerWithIdentifier("MenuVC") as? MenuViewController
            view.addSubview(menuViewCtr!.view!)
            addChildViewController(menuViewCtr!)
            menuViewCtr!.didMoveToParentViewController(self)
            menuViewCtr?.delegate = self
        }
        AnimateMenu(true)
        currentMenuState = MenuState.Open
    }
    
    func removeMenu() {
        println("removing menu")
        AnimateMenu(false)
        currentMenuState = MenuState.Closed
    }

    func AnimateMenu(open: Bool) {
        if(open){
            animateMenuBar(self.navCtr!.view.frame.width - 80, completion: nil)
        }else{
            animateMenuBar(0, completion: {
                finished in
                self.menuViewCtr?.removeFromParentViewController()
                self.menuViewCtr?.view.removeFromSuperview()
                self.menuViewCtr = nil
                self.currentMenuState = MenuState.Closed
            })
        }
    }

    func menuSelected(menu: String) {
        if(menu == "Me"){
            var profileVC = mainSb.instantiateViewControllerWithIdentifier("profileVC") as ProfileViewController
            var profileNavController = UINavigationController(rootViewController: profileVC)
            presentViewController(profileNavController, animated: true, completion: nil)
        }else if(menu == "Mentions"){
            var mentionVC = mainSb.instantiateViewControllerWithIdentifier("mentionVC") as MentionsViewController
            var mentionNavController = UINavigationController(rootViewController: mentionVC)
            presentViewController(mentionNavController, animated: true, completion: nil)
        }else if(menu == "Timeline"){
            var timelineVC = mainSb.instantiateViewControllerWithIdentifier("tweetsVC") as TweetsViewController
            var timelineNavController = UINavigationController(rootViewController: timelineVC)
            presentViewController(timelineNavController, animated: true, completion: nil)
        } else if(menu == "Logout"){
            User.CurrentUser?.Logout()
        }
        AnimateMenu(false)
   
    }
    
    func animateMenuBar(moveTo: CGFloat, completion: ((Bool) -> Void)! = nil){

        UIView.animateWithDuration(0.5,delay: 0,usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {self.navCtr?.view.frame.origin.x = moveTo
            return }, completion: completion)
        
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
