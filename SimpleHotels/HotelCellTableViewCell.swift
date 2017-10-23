//
//  HotelCellTableViewCell.swift
//  SimpleHotels
//
//  Created by Mark on 10/22/17.
//  Copyright © 2017 Expedia, Inc. All rights reserved.
//

import UIKit

class HotelCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
