//
//  Destinations.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 06/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

struct Destination {
    let name: String
    let location: Coordinate
    let icon: UIImage
    let image: String
}

enum Destinations: String {
    case amsterdam = "Amsterdam"
    case barcelona = "Barcelona"
    case edinburgh = "Edinburgh"
    case rome = "Rome"
    case florence = "Florence"
    case berlin = "Berlin"
    case paris = "Paris"
    case london = "London"
    
    var data: Destination {
        switch self {
        case .amsterdam: return Destination(name: rawValue, location: Coordinate(lat: 52.3702, long: 4.8952), icon: #imageLiteral(resourceName: "dest-amsterdam"), image: "https://images.unsplash.com/photo-1468436385273-8abca6dfd8d3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=2b7a96aa6b9bbe88b6bca8035f97c0dc")
        case .barcelona: return Destination(name: rawValue, location: Coordinate(lat: 41.3851, long: 2.1734), icon: #imageLiteral(resourceName: "dest-barcelona"), image: "https://images.unsplash.com/photo-1468793195345-d9d67818016d?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=c88f1492f19104f374c8590199bd4edd")
        case .edinburgh: return Destination(name: rawValue, location: Coordinate(lat: 55.9533, long: 3.1883), icon: #imageLiteral(resourceName: "dest-edinburgh"), image: "https://images.unsplash.com/photo-1507158008933-dbe2ca739ef3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=1ca5cc9028031a2d62e65be7259df5e9")
        case .berlin: return Destination(name: rawValue, location: Coordinate(lat: 52.5200, long: 13.4050), icon: #imageLiteral(resourceName: "dest-berlin"), image: "https://images.unsplash.com/photo-1516640543214-66f5cebe91de?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=46660762b19e63a3e3742c8ca91a4235")
        case .rome: return Destination(name: rawValue, location: Coordinate(lat: 41.9028, long: 12.4964), icon: #imageLiteral(resourceName: "dest-rome"), image: "https://images.unsplash.com/photo-1509024644558-2f56ce76c490?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=49013d74af8ca8694d4ff29e2d510df7")
        case .florence: return Destination(name: rawValue, location: Coordinate(lat: 43.7696, long: 11.2558), icon: #imageLiteral(resourceName: "dest-florence"), image: "https://images.unsplash.com/photo-1484918593501-d4ee2779f900?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=b8fb9166428ef13252cd3155a4125321")
        case .paris: return Destination(name: rawValue, location: Coordinate(lat: 48.8566, long: 2.3522), icon: #imageLiteral(resourceName: "dest-paris"), image: "https://images.unsplash.com/photo-1481828238384-55757d1249b8?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=6e4bc4bd11bb8a96850f67b15bc2300c")
        case .london: return Destination(name: rawValue, location: Coordinate(lat: 51.5074, long: 0.1278), icon: #imageLiteral(resourceName: "dest-london"), image: "https://images.unsplash.com/photo-1508711046474-2f4c2d3d30ca?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjIxODE1fQ&s=61dbab6964fb7e32c8e6b6bc79aa070e")
        }
    }
    
    static var count: Int { return self.london.hashValue + 1 }
    
    static var allDestinations = [amsterdam.data, barcelona.data, edinburgh.data, rome.data, florence.data, berlin.data, paris.data, london.data]
}

func returnCoords(for dest: Destinations.RawValue) -> Coordinate {
    switch dest {
    case "Amsterdam": return(Destinations.amsterdam.data.location)
    default: return(Coordinate(lat: 0, long: 0))
    }
}
