//
//  Venue Interior Table Controller.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 11/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//
import Foundation
import UIKit
import MapKit

class VenueInteriorTableController: UITableViewController {
    
    @IBOutlet weak var venueRatingLabel: CosmosView!
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueCategoryLabel: UILabel!
    @IBOutlet weak var venuePriceLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueLocationOnMap: MKMapView!
    
    //Serving Indicatiors
    @IBOutlet weak var servesWineLabel: UILabel!
    @IBOutlet weak var servesWineImage: UIImageView!
    @IBOutlet weak var servesFoodLabel: UILabel!
    @IBOutlet weak var servesFoodImage: UIImageView!
    @IBOutlet weak var offersRoomsLabel: UILabel!
    @IBOutlet weak var offersRoomsImage: UIImageView!
    

    var passedVenueImage: UIImage?
    
    var venue: Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentVenue = venue {
            configure(with: currentVenue)
            print(currentVenue.categories)
        }
    }
    
    //Configure the venue interior.
    func configure(with venue: Venue) {
        //Do image assignment outside of the view controller to avoid redownload.
        guard let interiorImage = passedVenueImage else { return }
        venueImage.image = interiorImage
        
        let viewModel = VenueInteriorViewModel(venue: venue)
        venueNameLabel.text = viewModel.venueName
        venueAddressLabel.text = viewModel.venueAddress
        venueCategoryLabel.text = viewModel.venueType
        venuePriceLabel.text = viewModel.price
        venueRatingLabel.rating = viewModel.venueRating
        
        //Wine Serving Indicator
        if viewModel.servesWine == true {
            servesWineLabel.text = "Serves Wine"
            servesWineImage.image = #imageLiteral(resourceName: " Wine Filled")
        } else {
            servesWineImage.image = #imageLiteral(resourceName: " Wine Not Filled")
            servesWineLabel.text = "No Wine"
            servesWineLabel.textColor = inactiveGrey
        }
        
        //Food Serving Indicator
        if viewModel.servesFood == true {
            servesFoodLabel.text = "Serves Food"
            servesFoodImage.image = #imageLiteral(resourceName: " Dinner Filled")
        } else {
            servesFoodImage.image = #imageLiteral(resourceName: " Dinner Not Filled")
            servesFoodLabel.text = "No Food"
            servesFoodLabel.textColor = inactiveGrey
        }
        
        //Offers Rooms Indicator
        if viewModel.offersRooms == true {
            offersRoomsImage.image = #imageLiteral(resourceName: " Hotel Filled")
            offersRoomsLabel.text = "Offers Rooms"
        } else {
            offersRoomsImage.image = #imageLiteral(resourceName: " Hotel Not Filled")
            offersRoomsLabel.text = "No Rooms"
            offersRoomsLabel.textColor = inactiveGrey
        }
        
        //Set up the map
        adjustMap(with: viewModel.location, on: venueLocationOnMap)
        venueLocationOnMap.addAnnotation(venue)
    }

 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}
