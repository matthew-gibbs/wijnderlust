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
    let categories: [YelpCategory]
    
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
        self.categories = venue.categories
        //FIXME: - Make this the first category.
        self.venueType = venue.categories.first!.title
        self.location = venue.location
        
        //MARK: - Indicators
        self.hasWineList = false
        
        //MARK: - Does it serve wine?
        self.servesWine = doesServeWine(categories: venue.categories)
        
        //MARK: - Does it serve food?
        self.servesFood = doesServeFood(categories: venue.categories)
        
        //MARK: - Does it offer rooms?
        self.offersRooms = doesOfferRooms(categories: venue.categories)
    }
}

