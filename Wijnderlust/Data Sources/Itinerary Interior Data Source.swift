//
//  ItineraryInteriorDataSource.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ItineraryInteriorDataSource: NSObject, UITableViewDataSource {
    
    private var itinerary: Itinerary
    private var hotel: Venue?
    private var places: [Venue] = []
    
    let tableView: UITableView
    let pendingOperations = PendingOperations()
    let numberOfRowsAtSection: [Int] = [3, 2]
    
    //FIXME: Figure a way to do the number of rows in the section based on the count...
    
    init(data: Itinerary, tableView: UITableView) {
        self.itinerary = data
        self.tableView = tableView
        super.init()
    }
    
    // MARK: Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section == 0 {
            rows = 3
        } else {
            if places.count == 0 {
                rows = 1
            } else {
                rows = places.count
            }
        }
        
        return rows
    }
    
    
    
    //MARK: View for Sections
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let placeholderCell = tableView.dequeueReusableCell(withIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
        let flightCell = tableView.dequeueReusableCell(withIdentifier: "FlightCell", for: indexPath) as! FlightCell
        let hotelCell = tableView.dequeueReusableCell(withIdentifier: "HotelCell", for: indexPath) as! HotelCell
        let venueCell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueCell
        
        //MARK: Start Flight Cell No Hotel Maker
        if (itinerary.flights != nil) && (itinerary.hotelId == nil) {
            let outboundFlightViewModel = FlightCellViewModel(itinerary: itinerary, flightType: .outbound)
            let inboundFlightViewModel = FlightCellViewModel(itinerary: itinerary, flightType: .inbound)
            
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    flightCell.configure(with: outboundFlightViewModel)
                    return flightCell
                } else if (indexPath.row == 1) {
                    placeholderCell.configure(for: .hotel, at: indexPath)
                    return placeholderCell
                } else if (indexPath.row == 2) {
                    flightCell.configure(with: inboundFlightViewModel)
                    return flightCell
                }
            }
        }
        //End Flight Cell No Hotel Maker
        
        //MARK: Start Flight and Hotel Maker
        if (itinerary.flights != nil) && (self.hotel != nil) {
            let outboundFlightViewModel = FlightCellViewModel(itinerary: itinerary, flightType: .outbound)
            let inboundFlightViewModel = FlightCellViewModel(itinerary: itinerary, flightType: .inbound)
            let hotelCellViewModel = HotelCellViewModel(itinerary: itinerary, hotel: hotel!)
            
            
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    flightCell.configure(with: outboundFlightViewModel)
                    return flightCell
                } else if (indexPath.row == 1) {
                    hotelCell.configure(with: hotelCellViewModel, flightStatus: .hasFlights)
                    if hotel!.photoState == .placeholder {
                        downloadPhotoForVenue(hotel!, atIndexPath: indexPath)
                    }
                    return hotelCell
                } else if (indexPath.row == 2) {
                    flightCell.configure(with: inboundFlightViewModel)
                    return flightCell
                }
            }
        }
        //End Flight and Hotel Maker
        
        
        //MARK: NO Flights, with Hotel
        if (itinerary.flights == nil) && (self.hotel != nil) {
            let hotelCellViewModel = HotelCellViewModel(itinerary: itinerary, hotel: hotel!)
            
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    placeholderCell.configure(for: .flightOutbound, at: indexPath)
                    return placeholderCell
                } else if (indexPath.row == 1) {
                    hotelCell.configure(with: hotelCellViewModel, flightStatus: .hasFlights)
                    if hotel!.photoState == .placeholder {
                        downloadPhotoForVenue(hotel!, atIndexPath: indexPath)
                    }
                    return hotelCell
                } else if (indexPath.row == 2) {
                    placeholderCell.configure(for: .flightInbound, at: indexPath)
                    return placeholderCell
                }
            }
        }
            
        //MARK: Itinerary Places
        if (places.count > 0) {
            if(indexPath.section == 1) {
                print(indexPath.row, places.count)
                let currentVenue = place(at: indexPath)
                
                let viewModel = VenueCellViewModel(venue: currentVenue)
                
                venueCell.configure(with: viewModel)
                
                if currentVenue.photoState == .placeholder {
                    downloadPhotoForVenue(currentVenue, atIndexPath: indexPath)
                }
                
                return venueCell
            }
        }
        
        //MARK: Placeholder Fallbacks
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                placeholderCell.configure(for: .flightOutbound, at: indexPath)
                return placeholderCell
            } else if (indexPath.row == 1) {
                placeholderCell.configure(for: .hotel, at: indexPath)
                return placeholderCell
            } else if (indexPath.row == 2) {
                placeholderCell.configure(for: .flightInbound, at: indexPath)
                return placeholderCell
            }
        }
        if (indexPath.section == 1) {
            placeholderCell.configure(for: .places, at: indexPath)
            return placeholderCell
        }
        //End Placeholder Fallbacks
        
        //MARK: Final Failure Clause for Compile purposes
        else {
            placeholderCell.configure(for: .error, at: indexPath)
            return placeholderCell
        }
    }
    
    
    
    //MARK: Helper methods
    func updateHotel(with data: Venue) {
        self.hotel = data
        tableView.reloadSections([0], with: .right)
    }
    
    func place(at indexPath: IndexPath) -> Venue {
        return places[indexPath.row]
    }

    func updateVenues(with data: Venue) {
        self.places.append(data)
        tableView.reloadSections([1], with: .right)
    }
    
    func downloadPhotoForVenue(_ venue: Venue, atIndexPath indexPath: IndexPath) {
        //Check to see if we have already started downloading this.
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            print("Already downloading the image.")
            return
        }
        
        //Otherwise download the artwork.
        let downloader = VenueImageDownloader(venue: venue)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                //Remove it from our current operations list.
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
}
