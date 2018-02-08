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
                let selectedVenue = dataSource.venue(at: selectedIndexPath)
                let venueDetailController = segue.destination as! VenueInteriorController
                
                venueDetailController.venue = selectedVenue
                print(selectedVenue.photoState)
                
                //Pass the current artwork through to the next screen.
                venueDetailController.venueImage = selectedVenue.photoState == .downloaded ? selectedVenue.photo! : #imageLiteral(resourceName: "placeholder")
                
                //TODO: - Reviews
//                venueDetailController.dataSource.updateData(selectedVenue.reviews)
            }
        }
    }

}
