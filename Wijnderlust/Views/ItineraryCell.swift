//
//  ItineraryCell.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class ItineraryCell: UITableViewCell {

    @IBOutlet weak var itineraryImage: UIImageView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var containerCell: UIView!
    
    //Indicators
    @IBOutlet weak var flightStatusIcon: UIImageView!
    @IBOutlet weak var flightStatusLabel: UILabel!
    @IBOutlet weak var hotelStatusIcon: UIImageView!
    @IBOutlet weak var hotelStatusLabel: UILabel!
    @IBOutlet weak var itineraryStatusIcon: UIImageView!
    @IBOutlet weak var itineraryStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Round the image corners
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.itineraryImage.frame
        rectShape.position = self.itineraryImage.center
        rectShape.path = UIBezierPath(roundedRect: self.itineraryImage.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        self.itineraryImage.layer.mask = rectShape
        
        //Setup shadow
        containerCell.layer.shadowColor = UIColor.black.cgColor
        containerCell.layer.shadowOpacity = 0.2
        containerCell.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerCell.layer.cornerRadius = 5
    }
    
    func configure(with viewModel: ItineraryCellViewModel) {
        itineraryImage.image = viewModel.itineraryImage
        startDateLabel.text = viewModel.startDate
        endDateLabel.text = viewModel.endDate
        destinationLabel.text = viewModel.title
        //FIXME: Do the indicators
    }

}
