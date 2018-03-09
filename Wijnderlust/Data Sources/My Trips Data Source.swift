//
//  My Trips Data Source.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class MyTripsDataSource: NSObject, UITableViewDataSource {
    
    private var itineraries: [Itinerary]
    
    let tableView: UITableView
    let pendingOperations = PendingOperations()
    
    init(data: [Itinerary], tableView: UITableView) {
        self.itineraries = data
        self.tableView = tableView
        super.init()
    }
    
    // MARK: Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if itineraries.count == 0 {
            return 1
        } else {
            return itineraries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if itineraries.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryCell", for: indexPath) as! ItineraryCell
            
            let currentItinerary = itinerary(at: indexPath)
            
            let viewModel = ItineraryCellViewModel(itinerary: currentItinerary)
            
            cell.configure(with: viewModel)
            
            if currentItinerary.photoState == .placeholder {
                downloadPhotoForItinerary(currentItinerary, atIndexPath: indexPath)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoTripsCell", for: indexPath) as! NoTripsCell
            
            return cell
        }
    }
    
    // MARK: Helpers
    
    func itinerary(at indexPath: IndexPath) -> Itinerary {
        return itineraries[indexPath.row]
    }
    
    func update(with data: [Itinerary]) {
        self.itineraries = data
    }
    
    func update(_ itinerary: Itinerary, at indexPath: IndexPath) {
        itineraries[indexPath.row] = itinerary
    }
    
    func downloadPhotoForItinerary(_ itinerary: Itinerary, atIndexPath indexPath: IndexPath) {
        //Check to see if we have already started downloading this.
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            print("Already downloading the image.")
            return
        }
        
        //Otherwise download the artwork.
        let downloader = ItineraryImageDownloader(itinerary: itinerary)
        
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
