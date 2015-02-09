//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Ambrish Verma on 2/5/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var moviesArray: NSArray?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=fc78yw2dsch8g4vqatk35fdk"
        let request = NSMutableURLRequest(URL: NSURL(string:RottenTomatoesURLString)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler: { (response, data, error) in
                var errorValue: NSError? = nil
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                
                self.moviesArray = dictionary["movies"] as NSArray
                self.tableView.reloadData()
        })
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = moviesArray {
            return array.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movieInfo = self.moviesArray![indexPath.row] as NSDictionary
       
        let cell = tableView.dequeueReusableCellWithIdentifier("com.skylord.mycell") as MovieTableViewCell
        
        
        let movieReleaseYear = movieInfo["year"] as Int
        let movieRuntime = movieInfo["runtime"] as Int
        let movieRating = movieInfo["mpaa_rating"] as NSString
        let movieCasts = movieInfo["abridged_cast"] as NSArray
        let movieImageTile = movieInfo["posters"] as NSDictionary
        let thumbNailUrlString = movieImageTile["thumbnail"] as NSString
        let thumbnailUrl = NSURL(string: thumbNailUrlString)
        let data = NSData(contentsOfURL: thumbnailUrl!)
        
        cell.MovieCellTitle.text = movieInfo["title"] as NSString
        cell.MovieYearLabel.text = "(\(movieReleaseYear))"
        cell.MovieDurationLabel.text = "\(movieRuntime) Mins"
        cell.MovieRatingLabel.text = " (\(movieRating))"
        cell.MovieImageView.image = UIImage(data: data!)
        
        var castString = ""
        for cast in movieCasts {
            castString += cast["name"] as NSString
            castString += ", "
        }
        cell.MovieCastLabel.text = castString

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let details = MoviesDetailViewController()
        let movie = self.moviesArray![indexPath.row] as NSDictionary
        details.movieDictionary = movie
        self.navigationController?.pushViewController(details, animated: true)
        
    }

    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Row: \(indexPath.row)")
    }
    */



}

