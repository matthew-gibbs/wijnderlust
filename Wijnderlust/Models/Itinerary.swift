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


enum ItineraryPhotoState {
    case placeholder
    case downloaded
    case failed
}

class Itinerary: NSObject, JSONInitialisable {
    let id: String
    let name: String
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
    let destination: Coordinate
    
    init(name: String, startDate: String, endDate: String) {
        self.id = "\(name)\(startDate)\(endDate)"
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.destination = getCoordForDest(name)
        self.imageUrl = "https://images.unsplash.com/photo-1468436385273-8abca6dfd8d3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=2b7a96aa6b9bbe88b6bca8035f97c0dc"
    }
    
    required init?(json: [String : Any]) {
        guard let name = json["destination"] as? String,
        let startDate = json["startDate"] as? String,
        let endDate = json["endDate"] as? String
        else { return nil }
        
        var places: [Venue] = []
        
        if let hotelId = json["hotelId"] as? String,
            let unparsedPlaces = json["places"] as? [[String : Any]],
            let flights = json["flights"] as? [String : Any] {
            
            //If places exist then build the array.
            for place in unparsedPlaces {
                if let currentVenue = Venue(json: place) {
                    places.append(currentVenue)
                }
            }
            self.places = places
            
            //If hotel is set, then give that here too.
            self.hotelId = hotelId
            
        }
        
        self.id = "\(name)\(startDate)\(endDate)"
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.imageUrl = "https://images.unsplash.com/photo-1468436385273-8abca6dfd8d3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=2b7a96aa6b9bbe88b6bca8035f97c0dc"
        
        self.destination = getCoordForDest(name)
        
        super.init()
    }
}


//Get coordinate for destination
func getCoordForDest(_ dest: String) -> Coordinate {
    let geoCoder = CLGeocoder()
    var coordLocation: Coordinate = Coordinate(lat: 0, long: 0)
    geoCoder.geocodeAddressString(dest) { (placemarks, error) in
    guard let placemarks = placemarks, let location = placemarks.first?.location else { return }
        
        coordLocation = Coordinate(lat: location.coordinate.latitude, long: location.coordinate.longitude)
    }
    return coordLocation
}
