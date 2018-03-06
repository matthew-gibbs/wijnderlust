//
//  Itinerary.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var imageClient = UnsplashClient()
let client = YelpClient()


enum ItineraryPhotoState {
    case placeholder
    case downloaded
    case failed
}

class Itinerary: NSObject, JSONInitialisable {
    let id: String
    let name: String
    let origin: String
    var photo: UIImage?
    var imageUrl: String
    var photoState = ItineraryPhotoState.placeholder
    var flights: [String: Any]?
    var outboundFlightNumber: String?
    var inboundFlightNumber: String?
    let startDate: Date
    let endDate: Date
    var hotelId: String?
    var places: [Venue]?
    var unparsedPlaces: [String]?
    let destination: Coordinate
    
    init(name: String, startDate: Date, endDate: Date, origin: String, imageUrl: String) {
        self.id = "\(name)\(startDate)\(endDate)"
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.destination = returnCoords(for: name)
        self.origin = origin
        self.imageUrl = imageUrl
    }
    
    required init?(json: [String : Any]) {
        guard let name = json["destination"] as? String,
        let startDate = json["startDate"] as? String,
        let endDate = json["endDate"] as? String,
        let imageUrl = json["imageUrl"] as? String,
        let origin = json["origin"] as? String
        else { return nil }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        
        if let unparsedPlaces = json["places"] as? [String] {
            self.unparsedPlaces = unparsedPlaces
        }
        
        if let flights = json["flights"] as? [String : Any] {
            self.flights = flights
            self.outboundFlightNumber = flights["outboundNumber"] as? String
            self.inboundFlightNumber = flights["inboundNumber"] as? String

        }
        
        if let hotelId = json["hotelId"] as? String {
            self.hotelId = hotelId
        }
        
        guard let formattedStartDate = dateFormatterGet.date(from: startDate) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        guard let formattedEndDate = dateFormatterGet.date(from: endDate) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
        self.id = "\(name)\(startDate)\(endDate)"
        self.name = name
        self.origin = origin
        self.startDate = formattedStartDate
        self.endDate = formattedEndDate
        self.imageUrl = imageUrl
        self.destination = returnCoords(for: name)

        super.init()
    }
}




