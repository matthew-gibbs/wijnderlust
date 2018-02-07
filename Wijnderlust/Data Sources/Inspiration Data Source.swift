//
//  Inspiration Data Source.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class InspirationDataSource: NSObject, UITableViewDataSource {
    
    private var data: [Venue]
    
    let tableView: UITableView
    
    init(data: [Venue], tableView: UITableView) {
        self.data = data
        self.tableView = tableView
        super.init()
    }
    
    // MARK: Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueCell
        
        let currentVenue = venue(at: indexPath)
        
        let viewModel = VenueCellViewModel(venue: currentVenue)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Restaurants"
        default: return nil
        }
    }
    
    // MARK: Helpers
    
    func venue(at indexPath: IndexPath) -> Venue {
        return data[indexPath.row]
    }
    
    func update(with data: [Venue]) {
        self.data = data
    }
    
    func update(_ object: Venue, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
}
