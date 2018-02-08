//
//  Venue Interior Controller.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 08/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class VenueInteriorController: UIViewController {
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueCategoryLabel: UILabel!
    @IBOutlet weak var venuePriceLabel: UILabel!
    @IBOutlet weak var venueRatingLabel: CosmosView!
    @IBOutlet weak var venueLocationOnMap: MKMapView!
    
    var passedVenueImage: UIImage?

    var venue: Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentVenue = venue {
            configure(with: currentVenue)
            print("Venue Set")
        }
    }
    
    //Configure the venue interior.
    func configure(with venue: Venue) {
        //Do image assignment outside of the view controller to avoid redownload.
        guard let interiorImage = passedVenueImage else { return }
        venueImage.image = interiorImage
        
        let viewModel = VenueInteriorViewModel(venue: venue)
        venueNameLabel.text = viewModel.venueName
        venueAddressLabel.text = viewModel.venueAddress
        venueCategoryLabel.text = viewModel.venueType
        venuePriceLabel.text = viewModel.price
        venueRatingLabel.rating = viewModel.venueRating
        
        //Set up the map
        adjustMap(with: viewModel.location, on: venueLocationOnMap)
        venueLocationOnMap.addAnnotation(venue)
    }
    
    
    
}
