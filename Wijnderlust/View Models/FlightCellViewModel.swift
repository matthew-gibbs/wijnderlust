//
//  FlightCellViewModel.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

enum FlightType {
    case inbound
    case outbound
}

struct FlightCellViewModel {
    let flightImage: UIImage
    let destination: String
    let flightNo: String
    let departureDate: String
    let mainLabel: String
    let origin: String
    let flightType: FlightType
    let wineListStatus: Bool = false
}

extension FlightCellViewModel {
    init(itinerary: Itinerary, flightType: FlightType) {
        self.flightImage = itinerary.photoState == .downloaded ? itinerary.photo! : #imageLiteral(resourceName: "placeholder")
        self.destination = itinerary.name.capitalized
        self.origin = itinerary.origin.capitalized
        self.flightType = flightType
        if flightType == .inbound {
            self.mainLabel = "Inbound to \(itinerary.origin.capitalized)"
            self.flightNo = itinerary.inboundFlightNumber!
            self.departureDate = itinerary.endDate
        } else {
            self.flightNo = itinerary.outboundFlightNumber!
            self.departureDate = itinerary.startDate
            self.mainLabel = "Outbound to \(itinerary.name.capitalized)"
        }
    }
}
