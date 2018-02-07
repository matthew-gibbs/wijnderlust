//
//  Yelp User.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

//To display reviews correctly.
class YelpUser: JSONInitialisable {
    
    enum ImageDownloadState {
        case placeholder, downloaded, failed
    }
    
    let name: String
    let imageUrl: String
    var image: UIImage? = nil
    var imageState: ImageDownloadState = .placeholder
    
    required init?(json: [String : Any]) {
        guard let imageUrl = json["image_url"] as? String, let name = json["name"] as? String else { return nil }
        self.imageUrl = imageUrl
        self.name = name
        self.image = nil
    }
}
