//
//  VenueCellViewModel.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

struct VenueCellViewModel {
    let venueImage: UIImage
    let venueAddress: String
    let venueRating: Double
    let wineList: Bool
    let venueName: String
}

extension VenueCellViewModel {
    init(venue: Venue) {
        self.venueImage = venue.photoState == .downloaded ? venue.photo! : #imageLiteral(resourceName: "placeholder")
        self.venueAddress = venue.address.address1
        self.venueRating = venue.rating
        self.wineList = false
        self.venueName = venue.name
    }
}

