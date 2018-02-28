//
//  Unsplash API Endpoint.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//
import Foundation

enum Unsplash {
    case getImage(term: String)
}

extension Unsplash: Endpoint {
    var base: String {
        return "https://api.unsplash.com"
    }
    
    var path: String {
        switch self {
        case .getImage: return "/search/photos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getImage(let term):
            return [
                URLQueryItem(name: "query", value: term),
                URLQueryItem(name: "orientation", value: "landscape"),
                URLQueryItem(name: "per_page", value: "1"),
                URLQueryItem(name: "page", value: "1")
            ]
        }
    }
}

