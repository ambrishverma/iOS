//
//  ViewController.swift
//  Canvas
//
//  Created by Ambrish Verma on 2/25/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var trayOriginalCenter: CGPoint!

    @IBOutlet var trayArrow: UIPanGestureRecognizer!
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayView.addGestureRecognizer(trayArrow)
        // Do any additional setup after loading the view, typically from a nib.
        trayOriginalCenter = trayView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dragTray(panGestureRecognizer: UIPanGestureRecognizer) {
        println("inside gesture recognizer")
        var translation = panGestureRecognizer.locationInView(trayView.superview!)
      //  trayCurrentCenter = trayView.center
        trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        
        var velocity = panGestureRecognizer.velocityInView(trayView.superview!)
        
        if (panGestureRecognizer.state == UIGestureRecognizerState.Ended) {
            
            if (velocity.y < 0) {
                println("moving up: \( trayView.center.y) and velocity: \(velocity.y)")
                trayView.center = trayOriginalCenter
            } else {
                println("moving down: \( trayView.center.y) and velocity: \(velocity.y)")
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + 200)
            }
        }
        
    }


}

