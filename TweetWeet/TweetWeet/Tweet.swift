//
//  Tweet.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/22/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var id: NSString
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int?
    var favoriteCount: Int?
    var favorited: Bool
    var retweetId: String
    var retweeted: Bool
    
    init(dictionary: NSDictionary){
        self.id = dictionary["id_str"] as NSString
        self.user = User(dictionary: dictionary["user"] as NSDictionary);
        self.text = (dictionary["text"] as NSString).stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        self.createdAtString = dictionary["created_at"] as NSString
        self.retweetCount = dictionary["retweet_count"] as? Int
        self.favoriteCount = dictionary["favorite_count"] as? Int
        self.favorited = dictionary["favorited"] as Bool
        self.retweetId = ""
        self.retweeted = dictionary["retweeted"] as Bool
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        //println(self.text)
    }
    
    class func tweetsFromArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary));
        }
        
        return tweets;
    }
}
