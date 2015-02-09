//
//  MoviesDetailViewController.swift
//  RottenTomatoes
//
//  Created by Ambrish Verma on 2/8/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    
    var movieDictionary: NSDictionary?

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
      var movieName = movieDictionary!["title"] as NSString
      println("\(movieName)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func loadView() {
        var myView = UIImageView(frame: CGRectZero)
        
        // Add Movie image
        let movieImageTile = self.movieDictionary!["posters"] as NSDictionary
        let thumbNailUrlString = movieImageTile["detailed"] as String
        let detailedUrlString = thumbNailUrlString.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let detailedlUrl = NSURL(string: detailedUrlString)
        let data = NSData(contentsOfURL: detailedlUrl!)
        myView.image = UIImage(data: data!)

        let movieDescription = self.movieDictionary!["synopsis"] as String
        
        var movieDescriptionView = UIView(frame: CGRectFromString(movieDescription))
   //     movieDescriptionView.
        
        //movieDescriptionView.backgroundColor = UIColor.whiteColor()
        myView.addSubview(movieDescriptionView)
        
        
        self.view = myView
        
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
