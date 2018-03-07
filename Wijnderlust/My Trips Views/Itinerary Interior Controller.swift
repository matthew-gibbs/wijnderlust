//
//  ItineraryController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ItineraryInteriorController: UITableViewController {
    let ref = Database.database().reference()
    let userId = UserDefaults.standard.getCurrentUserId()
    var itinerary: Itinerary?
    var passedDestinationImage: UIImage?
    
    @IBOutlet weak var itineraryTitleLabel: UILabel!
    @IBOutlet weak var itinerarySubtitleLabel: UILabel!
    
    //MARK: Delete Itinerary Handler
    @IBOutlet weak var deleteItineraryButton: UIButton!
    @IBAction func deleteItineraryAction(_ sender: Any) {
        //Initialise the alert
        let alert = UIAlertController(title: "Delete Itinerary", message: "This will permanently delete this itinerary, and everything you've added to it.", preferredStyle: .alert)
        
        //Delete Itinerary Action
        let deleteItineraryAction = UIAlertAction(title: "Delete Itinerary", style: .destructive) { (alert: UIAlertAction!) -> Void in
            let itineraryId = self.itinerary!.id
            
            self.ref.child("users/\(self.userId)/itineraries").child(itineraryId).removeValue { error, _ in
                print(error)
                print("Itinerary Deleted!")
            }
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(deleteItineraryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    lazy var dataSource: ItineraryInteriorDataSource = {
        return ItineraryInteriorDataSource(data: itinerary!, tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Interior View Loaded")
        guard let itinerary = itinerary else { return }
        itineraryTitleLabel.text = itinerary.name.capitalized
        
        //MARK: Update the day counter
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: itinerary.startDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        itinerarySubtitleLabel.text = "Only \(components.day!) Days To Go"
        tableView.dataSource = dataSource
    }
    
    //MARK: Selecting rows.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            guard let identifier = cell.reuseIdentifier else { return }
            
            if identifier == "PlaceholderCell" {
                let placeholderCell = cell as! PlaceholderCell
                let type = placeholderCell.type
                
                switch type {
                    case .flightInbound, .flightOutbound: performSegue(withIdentifier: "addFlightsSegue", sender: self)
                    case .hotel: performSegue(withIdentifier: "addHotelSegue", sender: self)
                    case .places: performSegue(withIdentifier: "addPlaceSegue", sender: self)
                    case .error: return
                }
            }
            
            if identifier == "HotelCell" {
                performSegue(withIdentifier: "addHotelSegue", sender: self)
            }
            
            if identifier == "FlightCell" {
                performSegue(withIdentifier: "addFlightsSegue", sender: self)
            }
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        print("Interior View Appeared")
        
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
        }
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
        if segue.identifier == "addFlightsSegue" {
            let addFlightsController = segue.destination as! AddFlightsController
            
            if let itinerary = self.itinerary {
               addFlightsController.itinerary = itinerary
            }
        }
        
        if segue.identifier == "addHotelSegue" {
            let addHotelController = segue.destination as! AddHotelController
            
            if let itinerary = self.itinerary {
                addHotelController.itinerary = itinerary
            }
        }
        
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

