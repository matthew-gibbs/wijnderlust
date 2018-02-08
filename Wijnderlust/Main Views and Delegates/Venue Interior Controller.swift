//
//  Venue Interior Controller.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 08/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class VenueInteriorController: UITableViewController {
    @IBOutlet weak var venuePhoto: UIImageView!
    
    var venueImage: UIImage?

    var venue: Venue? {
        didSet {
            if let currentVenue = venue {
                configure(with: currentVenue)
                print("Venue Set")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //Configure the venue interior.
    func configure(with venue: Venue) {
        self.title = venue.name
    }
    
}
