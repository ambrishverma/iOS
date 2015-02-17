//
//  PriceTableViewCell.swift
//  yelpHelp
//
//  Created by Ambrish Verma on 2/16/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol PriceTableViewCellDelegate : class{
    func didPriceChanged(priceTableViewCell:PriceTableViewCell, value: Int);
}

class PriceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var priceControl: UISegmentedControl!
    
    weak var delegate: PriceTableViewCellDelegate?;
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onPriceChanged(sender: AnyObject) {
           self.delegate?.didPriceChanged(self, value: priceControl.selectedSegmentIndex);
    }
    

}
