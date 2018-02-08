//
//  VenueInteriorViewModel.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 08/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

struct VenueInteriorViewModel {
    //Top Section
    let venueName: String
    let venueImage: UIImage
    let venueAddress: String
    let venueRating: Double
    let price: String
    let venueType: String
    let location: Coordinate
    
    //Indicators
    let hasWineList: Bool
    let servesWine: Bool
    let servesFood: Bool
    let offersRooms: Bool
}

extension VenueInteriorViewModel {
    init(venue: Venue) {
        self.venueName = venue.name
        self.venueImage = venue.photoState == .downloaded ? venue.photo! : #imageLiteral(resourceName: "placeholder")
        self.venueAddress = venue.address.address1
        self.venueRating = venue.rating
        self.price = venue.price
        //FIXME: - Make this the first category.
        self.venueType = "Wine Bar"
        self.location = venue.location
        
        //FIXME: - Make Indicators Work
        self.hasWineList = false
        self.servesWine = false
        self.servesFood = false
        self.offersRooms = false
    }
}

