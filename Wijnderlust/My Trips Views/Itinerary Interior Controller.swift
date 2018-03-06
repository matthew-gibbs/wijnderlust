//
//  ItineraryController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class ItineraryInteriorController: UITableViewController {
    @IBOutlet weak var itineraryTitleLabel: UILabel!
    @IBOutlet weak var itinerarySubtitleLabel: UILabel!
    
    var itinerary: Itinerary?
    var passedDestinationImage: UIImage?
    
    
    lazy var dataSource: ItineraryInteriorDataSource = {
        return ItineraryInteriorDataSource(data: (itinerary)!, tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        itineraryTitleLabel.text = itinerary?.name.capitalized
        
        if let itinerary = itinerary {
            if let hotel = itinerary.hotelId {
                client.venueWithId(hotel) { result in
                    switch result {
                    case .success(let hotel):
                        self.dataSource.updateHotel(with: hotel)
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            if let venueIds = itinerary.unparsedPlaces {
                var places: [Venue] = []
                for id in venueIds {
                    print(id)
                    client.venueWithId(id) { result in
                        switch result {
                        case .success(let venue):
                            print(venue)
                            places.append(venue)
                            self.dataSource.updateVenues(with: venue)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            
            //MARK: Update the day counter
            let calendar = NSCalendar.current
            
            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: itinerary.startDate)
            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            itinerarySubtitleLabel.text = "Only \(components.day!) Days To Go"
            
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVenue" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedVenue = dataSource.place(at: selectedIndexPath)
                let venueDetailController = segue.destination as! VenueInteriorTableController
                
                //Set custom back image
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                
                if let interiorImage = selectedVenue.photo {
                    print(interiorImage)
                    venueDetailController.passedVenueImage = interiorImage
                    venueDetailController.venue = selectedVenue
                }
                
                //TODO: - Reviews
                //                venueDetailController.dataSource.updateData(selectedVenue.reviews)
            }
        }
    }
}


