//
//  Review.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 05/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation

class Review {
    var title: String
    var body: String
    var rating: Int
    var venueId: String
    var venue: String
    var date: Date
    
    init(title: String, body: String, rating: Int, venueId: String, venue: String, date: Date) {
        self.title = title
        self.body = body
        self.rating = rating
        self.venueId = venueId
        self.venue = venue
        self.date = date
    }
}


