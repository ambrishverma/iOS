//
//  TweetTableTableViewCell.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/22/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate: class{
    func didFavoriteChanged(tweetTableViewCell: TweetTableViewCell, tweetValue: Tweet)
}

class TweetTableTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var userLabel: UILabel!
    
    
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
