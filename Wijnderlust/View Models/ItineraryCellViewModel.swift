//
//  ItineraryCellViewModel.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

struct ItineraryCellViewModel {
    let itineraryImage: UIImage
    let title: String
    let startDate: String
    let endDate: String
    var hasFlights: Bool = false
    var hasHotel: Bool = false
    var hasItinerary: Bool = false
}

extension ItineraryCellViewModel {
    init(itinerary: Itinerary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        self.itineraryImage = itinerary.photoState == .downloaded ? itinerary.photo! : #imageLiteral(resourceName: "placeholder")
        self.title = itinerary.name.capitalized
        self.startDate = itinerary.startDate
        self.endDate = itinerary.endDate
//        self.startDate = dateFormatter.string(from: itinerary.startDate)
//        self.endDate = dateFormatter.string(from: itinerary.endDate)
        if (itinerary.flights != nil) {
            self.hasFlights = true
        }
        if (itinerary.hotelId != nil) {
            self.hasHotel = true
        }
        if (itinerary.places != nil) {
            self.hasItinerary = true
        }
    }
}
