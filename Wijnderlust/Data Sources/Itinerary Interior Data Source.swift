//
//  ItineraryInteriorDataSource.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class ItineraryInteriorDataSource: NSObject, UITableViewDataSource {
    
    private var itinerary: Itinerary
    
    let tableView: UITableView
    let pendingOperations = PendingOperations()
    let numberOfRowsAtSection: [Int] = [3, 1]
    
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
        
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }
    
    //MARK: View for Sections
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let placeholderCell = tableView.dequeueReusableCell(withIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
        let flightCell = tableView.dequeueReusableCell(withIdentifier: "FlightCell", for: indexPath) as! FlightCell
        
        //MARK: Start Flight Cell No Hotel Maker
        if (itinerary.flights != nil) && (itinerary.hotelId == nil) {
            let outboundFlightViewModel = FlightCellViewModel(itinerary: itinerary, flightType: .outbound)
            let inboundFlightViewModel = FlightCellViewModel(itinerary: itinerary, flightType: .inbound)
            
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    flightCell.configure(with: outboundFlightViewModel)
                    return flightCell
                } else if (indexPath.row == 1) {
                    placeholderCell.configure(for: "hotelMiddle", at: indexPath)
                    return placeholderCell
                } else if (indexPath.row == 2) {
                    flightCell.configure(with: inboundFlightViewModel)
                    return flightCell
                }
            }
        }
        //End Flight Cell No Hotel Maker
        
        //MARK: Start Flight and Hotel Maker
        if (itinerary.flights != nil) && (itinerary.hotelId != nil) {
            let outboundFlightViewModel = FlightCellViewModel(itinerary: itinerary, flightType: .outbound)
            let inboundFlightViewModel = FlightCellViewModel(itinerary: itinerary, flightType: .inbound)
            
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    flightCell.configure(with: outboundFlightViewModel)
                    return flightCell
                } else if (indexPath.row == 1) {
                    placeholderCell.configure(for: "hotelMiddle", at: indexPath)
                    return placeholderCell
                } else if (indexPath.row == 2) {
                    flightCell.configure(with: inboundFlightViewModel)
                    return flightCell
                }
            }
        }
        //End Flight and Hotel Maker
        
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                placeholderCell.configure(for: "hotel", at: indexPath)
                return placeholderCell
            }
        }
        if (indexPath.section == 1) {
            placeholderCell.configure(for: "places", at: indexPath)
            return placeholderCell
        }
        
        
        else {
            placeholderCell.configure(for: "places", at: indexPath)
            return placeholderCell
        }
    }
    
}
