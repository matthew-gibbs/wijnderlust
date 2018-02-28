//
//  Itinerary.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Firebase

var imageClient = UnsplashClient()
let geoCoder = CLGeocoder()
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
    let startDate: String
    let endDate: String
    var hotelId: String?
    var places: [Venue]?
    var unparsedPlaces: [String]?
    let destination: Coordinate
    
    init(name: String, startDate: String, endDate: String, origin: String) {
        self.id = "\(name)\(startDate)\(endDate)"
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.destination = getCoordForDest(name)
        self.origin = origin
        self.imageUrl = "void"
    }
    
    required init?(json: [String : Any]) {
        guard let name = json["destination"] as? String,
        let startDate = json["startDate"] as? String,
        let endDate = json["endDate"] as? String,
        let imageUrl = json["imageUrl"] as? String,
        let origin = json["origin"] as? String
        else { return nil }
        
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
        
        self.id = "\(name)\(startDate)\(endDate)"
        self.name = name
        self.origin = origin
        self.startDate = startDate
        self.endDate = endDate
        self.imageUrl = imageUrl
        self.destination = getCoordForDest(name)
        print(getCoordForDest(name))

        super.init()
    }
}


//Get coordinate for destination
func getCoordForDest(_ dest: String) -> Coordinate {
    var coordLocation: Coordinate = Coordinate(lat: 0, long: 0)
    geoCoder.geocodeAddressString(dest) { (placemarks, error) in
    guard let placemarks = placemarks, let location = placemarks.first?.location else { return }
        
        coordLocation = Coordinate(lat: location.coordinate.latitude, long: location.coordinate.longitude)
    }
    return coordLocation
}


