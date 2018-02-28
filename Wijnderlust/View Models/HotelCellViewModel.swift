//
//  HotelCellViewModel.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 28/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

struct HotelCellViewModel {
    let hotelImage: UIImage?
    let hotelName: String
    let checkInDate: String
    let checkOutDate: String
    let wineListStatus: Bool = false
}

extension HotelCellViewModel {
    init(itinerary: Itinerary) {
        self.hotelImage = itinerary.photoState == .downloaded ? itinerary.photo! : #imageLiteral(resourceName: "placeholder")
        self.hotelName = "Ambassade Hotel Test"
        self.checkInDate = itinerary.startDate
        self.checkOutDate = itinerary.endDate
    }
}
