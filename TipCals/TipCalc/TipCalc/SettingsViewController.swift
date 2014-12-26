//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Ambrish Verma on 12/25/14.
//  Copyright (c) 2014 Ambrish Verma. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        defaultTipControl.selectedSegmentIndex = MyVariables.defaultTipPercentageIndex
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

    
    /*
        update default tip settings
    */
    @IBAction func onUpdate(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        var newSelectedIndex = defaultTipControl.selectedSegmentIndex
        // update new values in global variables
        MyVariables.defaultTipPercentageIndex = newSelectedIndex
        
        // update new value in persistent storage
        defaults.setInteger(newSelectedIndex, forKey: "Default_Tip_Index")
        defaults.synchronize()
    }
    
}
