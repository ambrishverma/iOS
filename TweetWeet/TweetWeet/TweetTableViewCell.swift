//
//  TweetTableViewCell.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/22/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate: class{
    func didFavoriteChanged(tweetTableViewCell: TweetTableViewCell, tweetValue: Tweet)
}


class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!

    weak var delegate: TweetTableViewCellDelegate?
    var currentTweet: Tweet!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setTweet(tweet: Tweet) {
        self.profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
       // self.tweetLabel.text = tweet.text
        self.userLabel.text = tweet.user!.name
        self.handleLabel.text = "@\(tweet.user!.screenName)"
       // self.createdAtLabel.text = tweet.createdAt.shortTimeAgoSinceNow()
     //   self.favoriteBtn.imageView?.image = tweet.favorited ? UIImage(named: "favorite_on") : UIImage(named: "favorite")
       // self.retweetedBtn.imageView?.image = tweet.retweeted ? UIImage(named: "retweet_on") : UIImage(named: "retweet")
       // replyBtn.tag = tweet.id.integerValue
        currentTweet = tweet
    }
    

}
