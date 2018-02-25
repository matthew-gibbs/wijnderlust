//
//  ItineraryImageDownloader.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class ItineraryImageDownloader: Operation {
    let itinerary: Itinerary
    
    init(itinerary: Itinerary) {
        self.itinerary = itinerary
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: itinerary.imageUrl) else {
            return
        }
        
        let imageData = try! Data(contentsOf: url)
        
        if self.isCancelled {
            return
        }
        
        //Check the byte count to make sure it exists.
        if imageData.count > 0 {
            itinerary.photo = UIImage(data: imageData)
            itinerary.photoState = .downloaded
        } else {
            itinerary.photoState = .failed
        }
    }
}
