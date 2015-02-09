//
//  MovieTableViewCell.swift
//  RottenTomatoes
//
//  Created by Ambrish Verma on 2/7/15.
//  Copyright (c) 2015 Skylord. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var MovieCellTitle: UILabel!

    @IBOutlet weak var MovieYearLabel: UILabel!
    
    @IBOutlet weak var MovieRatingLabel: UILabel!
    
    @IBOutlet weak var MovieDurationLabel: UILabel!
    
    @IBOutlet weak var MovieCastLabel: UILabel!
    
    @IBOutlet weak var MovieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
