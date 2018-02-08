//
//  VenueImage Downloader.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class VenueImageDownloader: Operation {
    let venue: Venue
    
    init(venue: Venue) {
        self.venue = venue
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: venue.imageUrl) else {
            return
        }
        
        let imageData = try! Data(contentsOf: url)
        
        if self.isCancelled {
            return
        }
        
        //Check the byte count to make sure it exists.
        if imageData.count > 0 {
            venue.photo = UIImage(data: imageData)
            venue.photoState = .downloaded
        } else {
            venue.photoState = .failed
        }
    }
}
