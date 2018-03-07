//
//  HotelListCell.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class HotelListCell: UITableViewCell {
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelAddressLabel: UILabel!
    var hotel: Venue?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with hotel: Venue) {
        hotelNameLabel.text = hotel.name
        hotelAddressLabel.text = hotel.address.address1
        self.hotel = hotel
    }
}
