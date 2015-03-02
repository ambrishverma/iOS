//
//  ViewController.swift
//  HamburgerMenu
//
//  Created by Anoop tomar on 2/25/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MainViewControllerDelegate {

    var mainViewCtrl: MainViewController?
    var menuViewCtrl: MenuViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as? MainViewController
        
        mainViewCtrl?.delegate = self
        addMainView()
    }
    
    func addMainView(){
        self.view.addSubview(mainViewCtrl!.view)
        self.addChildViewController(mainViewCtrl!)
        mainViewCtrl!.didMoveToParentViewController(self)
    }
    
    func toggleMenu() {
        if(menuViewCtrl == nil){
            menuViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("menuVC") as? MenuViewController
            
            self.view.insertSubview(menuViewCtrl!.view, atIndex: 0)
            self.addChildViewController(menuViewCtrl!)
            menuViewCtrl?.didMoveToParentViewController(mainViewCtrl)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.mainViewCtrl!.view.frame.origin.x = self.mainViewCtrl!.view.frame.width - 50
                }, completion: nil)
        }else{
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.mainViewCtrl!.view.frame.origin.x = 0
                }, completion: {
                finished in
                
                self.menuViewCtrl!.view.removeFromSuperview()
                self.menuViewCtrl!.removeFromParentViewController()
                self.menuViewCtrl = nil
            })
        }
    }

}

