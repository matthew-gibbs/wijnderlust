//
//  Coordinate.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
    
    init(lat: Double, long: Double) {
        self.latitude = lat
        self.longitude = long
    }
}

//MARK: - When has location data
extension Coordinate: JSONInitialisable {
    init?(json: [String : Any]) {
        guard let latitudeValue = json["latitude"] as? Double, let longitudeValue = json["longitude"] as? Double else { return nil }
        self.latitude = latitudeValue
        self.longitude = longitudeValue
    }
}

