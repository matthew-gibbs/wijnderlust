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
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yy"
        
        
        self.itineraryImage = itinerary.photoState == .downloaded ? itinerary.photo! : #imageLiteral(resourceName: "placeholder")
        self.title = itinerary.name.capitalized
        self.startDate = dateFormatterPrint.string(from: itinerary.startDate)
        self.endDate = dateFormatterPrint.string(from: itinerary.endDate)
        if (itinerary.flights != nil) {
            self.hasFlights = true
        }
        if (itinerary.hotelId != nil) {
            self.hasHotel = true
        }
        
        guard let places = itinerary.unparsedPlaces else { return }
        if (places.count > 0) {
            self.hasItinerary = true
        }
    }
}
