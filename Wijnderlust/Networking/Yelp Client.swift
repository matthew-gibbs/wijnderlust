//
//  Yelp Client.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation

class YelpClient: APIClient {
    let session: URLSession
    private let apiKey = "tQue9yv8DM-k3QPOkHLYFF4yskXqpRm8IOvxQ2ixIQ0LbHbvfmzpPZ0MmCmX-sDSP2NZOgpLT_QXac2h9f-vRe096Hazt0zurPaB1QZt9CsbBnOjNloGrDcQkAh7WnYx"
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func search(withTerm term: String, at coordinate: Coordinate, categories: [YelpCategory] = [], radius: Int? = nil, limit: Int = 50, sortBy sortType: Yelp.YelpSortType = .rating, completion: @escaping (Result<[Venue], APIError>) -> Void) {
        
        let endpoint = Yelp.search(term: term, coordinate: coordinate, radius: radius, categories: categories, limit: limit, sortBy: sortType)
        var request = endpoint.request
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        fetch(with: request, parse: { json -> [Venue] in
            guard let businesses = json["businesses"] as? [[String: Any]] else { return [] }
            return businesses.flatMap { Venue(json: $0) }
            
        }, completion: completion)
    }
    
    func venueWithId(_ id: String, completion: @escaping (Result<Venue, APIError>) -> Void) {
        let endpoint = Yelp.business(id: id)
        var request = endpoint.request
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        fetch(with: request, parse: { json -> Venue? in
            return Venue(json: json)
        }, completion: completion)
    }
    
    func reviews(for business: Venue, completion: @escaping (Result<[YelpReview], APIError>) -> Void) {
        let endpoint = Yelp.reviews(businessId: business.id)
        var request = endpoint.request
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        fetch(with: request, parse: { json -> [YelpReview] in
            guard let reviews = json["reviews"] as? [[String: Any]] else { return [] }
            return reviews.flatMap { YelpReview(json: $0) }
        }, completion: completion)
    }
}

