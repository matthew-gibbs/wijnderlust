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
    @IBOutlet weak var containerCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Round the image corners
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.venueImage.frame
        rectShape.position = self.venueImage.center
        rectShape.path = UIBezierPath(roundedRect: self.venueImage.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        self.venueImage.layer.mask = rectShape
        
        //Setup shadow
        containerCell.layer.shadowColor = UIColor.black.cgColor
        containerCell.layer.shadowOpacity = 0.2
        containerCell.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
