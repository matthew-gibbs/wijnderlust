//
//  DestinationInspirationDataSource.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 09/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class DestinationInspirationDataSource: NSObject, UITableViewDataSource {
    
    private var venues: [Venue]
    
    let tableView: UITableView
    let pendingOperations = PendingOperations()
    
    init(data: [Venue], tableView: UITableView) {
        self.venues = data
        self.tableView = tableView
        super.init()
    }
    
    // MARK: Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueCell
        
        let currentVenue = venue(at: indexPath)
        
        let viewModel = VenueCellViewModel(venue: currentVenue)
        
        cell.configure(with: viewModel)
        
        if currentVenue.photoState == .placeholder {
            downloadPhotoForVenue(currentVenue, atIndexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK: Helpers
    
    func venue(at indexPath: IndexPath) -> Venue {
        return venues[indexPath.row]
    }
    
    func update(with data: [Venue]) {
        self.venues = data
    }
    
    func update(_ venue: Venue, at indexPath: IndexPath) {
        venues[indexPath.row] = venue
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
