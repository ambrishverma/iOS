//
//  MenuTableViewCell.swift
//  TweetWeet
//
//  Created by Ambrish Verma on 2/28/15.
//  Copyright (c) 2015 skylord.co. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var menuItem: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
