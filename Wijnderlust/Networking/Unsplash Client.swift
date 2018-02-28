//
//  Google Places API.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation


class UnsplashClient: APIClient {
    let session: URLSession
    private let apiKey = "4ec08d9b157da787a27f8e00c0c7e9734fe1a727f240bb19eb8988b244d37f79"
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getImage(forPlace term: String, completion: @escaping (Result<[UnsplashImage], APIError>) -> Void) {
        
        let endpoint = Unsplash.getImage(term: term)
        var request = endpoint.request
        request.setValue("Client-ID \(apiKey)", forHTTPHeaderField: "Authorization")
        
        fetch(with: request, parse: { json -> [UnsplashImage] in
            guard let image = json["results[1]"] as? [[String: Any]] else { return [] }
            return image.flatMap { UnsplashImage(json: $0) }
            
        }, completion: completion)    }
}

class UnsplashResult: JSONInitialisable {
    required init?(json: [String : Any]) {
        return
    }
}
