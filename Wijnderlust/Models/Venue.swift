//
//  Venue.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

enum VenuePhotoState {
    case placeholder
    case downloaded
    case failed
}

class Venue: NSObject, JSONInitialisable {
    let id: String
    let name: String
    let imageUrl: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [YelpCategory]
    let rating: Double
    let location: Coordinate
    let address: Address
    let phone: String
    let displayPhone: String
    let price: String
    var photo: UIImage?
    var photoState = VenuePhotoState.placeholder
    
    // Only available through search results not direct business queries
    var distance: Double?
    
    // Reviews
    var reviews: [YelpReview]
    
    required init?(json: [String : Any]) {
        guard let id = json["id"] as? String,
            let name = json["name"] as? String,
            let imageUrl = json["image_url"] as? String,
            let isClosed = json["is_closed"] as? Bool,
            let url = json["url"] as? String,
            let reviewCount = json["review_count"] as? Int,
            let categoriesDict = json["categories"] as? [[String: Any]],
            let rating = json["rating"] as? Double,
            let coordinatesDict = json["coordinates"] as? [String: Any],
            let coordinates = Coordinate(json: coordinatesDict),
            let location = json["location"] as? [String: Any],
            let address = Address(json: location),
            let price = json["price"] as? String,
            let phone = json["phone"] as? String,
            let displayPhone = json["display_phone"] as? String
            else { return nil }
        
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.isClosed = isClosed
        self.url = url
        self.reviewCount = reviewCount
        self.categories = categoriesDict.flatMap { YelpCategory(json: $0) }
        self.rating = rating
        self.location = coordinates
        self.address = address
        self.phone = phone
        self.displayPhone = displayPhone
        self.price = price
        
        self.distance = json["distance"] as? Double
        
        self.reviews = []
        
        super.init()
    }
}

//Conform to the map pin protocol
import MapKit

extension Venue: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    var title: String? {
        return name
    }
}
