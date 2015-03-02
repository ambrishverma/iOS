//
//  ProfileTableViewCell.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 3/1/15.
//  Copyright (c) 2015 skylord.co. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userHandle: UILabel!
    
    
    @IBOutlet weak var tweetBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImage.layer.cornerRadius = 5
        self.profileImage.clipsToBounds = true
        self.tweetBody.preferredMaxLayoutWidth = self.tweetBody.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCells(tweet: Tweet){
        self.profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
        self.userName.text = tweet.user?.name
    //    self.createdAtText.text = tweet.createdAt?.timeAgoSinceNow()
        self.userHandle.text = "@\(tweet.user!.screenName)"
        self.tweetBody.text = tweet.text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tweetBody.preferredMaxLayoutWidth = self.tweetBody.frame.size.width
    }
}
