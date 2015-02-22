//
//  TwitterClient.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/21/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

let twitterConsumerKey = "st0wLS9CbmKowny8rZ3VQidew"
let twitterConsumerSecret = "IorUu2CU7o9Uw1XRYomcgmnmKJ6G4sEVrsUvxSUVq26Cm18EGk"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        // Get user tweets
        GET("1.1/statuses/home_timeline.json", parameters: nil,
            success: {
                (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("\(response)")
                
                var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                completion(tweets: tweets, error: nil)
                for tweet in tweets {
                    println("at \(tweet.createdAt) : \(tweet.text)")
                }
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed getting current user")
                completion(tweets: nil , error: error)
        })

    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        // fetch request token
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "sltwitterdemo://oauth"), scope: nil,
            success: {
                (requestToken: BDBOAuthToken!) -> Void in
                println("Got requst token")
                
                var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
                
            },
            failure: {
                (error: NSError!) -> Void in
                println("failed")
                self.loginCompletion?(user: nil, error: error)
        })
        
    }
    
    
    func openURL(url: NSURL) {
   
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query),
            success: {
                (accessToken: BDBOAuthToken!) -> Void in
                println("Got access token")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                // Get user credentials
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                    success: {
                        (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        //println("\(response)")
                        
                        var user = User(dictionary: response as NSDictionary)
                        println("user: \(user.name)")
                        User.currentUser = user
                        self.loginCompletion?(user: user, error: nil)
                    },
                    failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("failed getting current user")
                        self.loginCompletion?(user: nil, error: error)
                })
                
            },
            failure: {
                (error: NSError!) -> Void in
                println("failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        })

        
    }
    
    
    
}
