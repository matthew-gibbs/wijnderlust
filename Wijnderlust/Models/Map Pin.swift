//
//  Map Pin.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 18/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import MapKit

class VenuePin: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var venue: Venue
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: Coordinate, venue: Venue) {
        self.venue = venue
        self.title = title
        self.subtitle = subtitle
        self.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
