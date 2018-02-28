//
//  UnsplashImage.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation

class UnsplashImage: NSObject, JSONInitialisable {
    let imageLink: String? = "NULL"
    
    required init?(json: [String : Any]) {
        guard let results = json["urls"] else { print("Failed"); return }
        
        print(results)
    }
}
