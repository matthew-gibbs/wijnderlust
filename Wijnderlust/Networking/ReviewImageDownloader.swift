//
//  ReviewImageDownloader.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 08/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class ReviewImageDownloader: Operation {
    let review: YelpReview
    
    init(review: YelpReview) {
        self.review = review
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: review.user.imageUrl) else {
            return
        }
        
        let imageData = try! Data(contentsOf: url)
        
        if self.isCancelled {
            return
        }
        
        //Check the byte count to make sure it exists.
        if imageData.count > 0 {
            review.user.image = UIImage(data: imageData)
            review.user.imageState = .downloaded
        } else {
            review.user.imageState = .failed
        }
    }
}
