//
//  VenueCell.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueRating: CosmosView!
    @IBOutlet weak var wineStatusImage: UIImageView!
    @IBOutlet weak var wineStatusLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //configure from a view model
    func configure(with viewModel: VenueCellViewModel) {
        venueImage.image = viewModel.venueImage
        venueAddressLabel.text = viewModel.venueAddress
        venueRating.rating = viewModel.venueRating
        venueNameLabel.text = viewModel.venueName
        
        //FIXME: - Wine Status Indicator.
    }
}
