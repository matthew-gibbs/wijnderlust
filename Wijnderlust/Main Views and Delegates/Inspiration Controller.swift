//
//  InspirationController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class InspirationController: UITableViewController {
    
    let client = YelpClient()
    
    lazy var dataSource: InspirationDataSource = {
        return InspirationDataSource(data: [], tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        client.search(withTerm: "wine bar", at: Coordinate(lat: 51.5033640, long: -0.1276250)) { [weak self] result in
            switch result {
            case .success(let businesses):
                self?.dataSource.update(with: businesses)
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVenue" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedVenue = dataSource.venue(at: selectedIndexPath)
                let venueDetailController = segue.destination as! VenueInteriorController
                
                //Set custom back image
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                
                if let interiorImage = selectedVenue.photo {
                    print(interiorImage)
                    venueDetailController.passedVenueImage = interiorImage
                    venueDetailController.venue = selectedVenue
                }
                
                // API Call - no longer required #SPEEEEEEEEEEEEED
//                client.venueWithId(selectedVenue.id) { result in
//                    switch result {
//                    case .success(let venue):
//                        venueDetailController.venue = venue
//                        venueDetailController.title = venue.name
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
                
                //TODO: - Reviews
//                venueDetailController.dataSource.updateData(selectedVenue.reviews)
            }
        }
    }

}
