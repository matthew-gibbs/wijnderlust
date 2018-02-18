//
//  Yelp Category.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation

struct YelpCategory {
    let alias: String
    let title: String
}

extension YelpCategory: JSONInitialisable {
    init?(json: [String : Any]) {
        guard let aliasValue = json["alias"] as? String, let titleValue = json["title"] as? String else { return nil }
        
        self.alias = aliasValue
        self.title = titleValue
    }
}

