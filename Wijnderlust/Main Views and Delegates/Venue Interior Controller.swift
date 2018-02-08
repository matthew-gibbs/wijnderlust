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
    
    //Setup image to pass to venue image
    var venueImage: UIImage?

    var venue: Venue? {
        didSet {
            if let venue = venue {
                configure(with: venue)
//                dataSource.update(with: venue)
                tableView.reloadData()
            }
        }
    }
    
//    var dataSource = VenueInteriorDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let venue = venue else { return }
        self.title = venue.name
        
        //Set Photo
        if let venueImage = venueImage {
            venuePhoto.image = venueImage
        }
        
//        tableView.dataSource = dataSource
    }
    
    
    
    func configure(with venue: Venue) {
        //Configure the view
        
    }
    
}
