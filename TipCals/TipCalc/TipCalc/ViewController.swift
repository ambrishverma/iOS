//
//  ViewController.swift
//  TipCalc
//
//  Created by Ambrish Verma on 12/25/14.
//  Copyright (c) 2014 Ambrish Verma. All rights reserved.
//

import UIKit

struct MyVariables {
    static var tipPercentages = [0.15, 0.20, 0.25]
    static var defaultTipPercentageIndex = 0
    static var currentAmount:Double = 0.0
    static var timeSaved:NSDate = NSDate()
}

class ViewController: UIViewController {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // read detaulfs from the persistent keys
        var defaults = NSUserDefaults.standardUserDefaults()
        var intValue = defaults.integerForKey("Default_Tip_Index")
        println("default value: \(intValue)")
        
        // load default values in global variables & views
        MyVariables.defaultTipPercentageIndex = intValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func onEdit(sender: AnyObject) {
        var tipPercentage = MyVariables.tipPercentages[tipControl.selectedSegmentIndex]
        var amount = (amountField.text as NSString).doubleValue
        
        var tip = amount * tipPercentage
        var total = amount + tip

        String(format:"%.2f", tip)
        String(format:"%.2f", total)
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        // save the amount to global stogage
        MyVariables.currentAmount = amount
    }
    
    @IBAction func OnTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear, \(MyVariables.currentAmount)")
        
        tipControl.selectedSegmentIndex = MyVariables.defaultTipPercentageIndex
        let timeNow:NSDate = NSDate()
        
        // check if less than 10 mins passed then retain value
        if timeNow.timeIntervalSinceDate(MyVariables.timeSaved) < 10*60  {
            
            if MyVariables.currentAmount > 0 {
                amountField.text = String(format: "%.2f", MyVariables.currentAmount)
            
            }
        }
        else  {
            MyVariables.currentAmount = 0
        }
        
        
        onEdit(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        /* save amount to persistent keys
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(MyVariables.currentAmount, forKey: "Current_Amount")
*/
        println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("view did disappear")
        
        MyVariables.timeSaved = NSDate()
    }

}

