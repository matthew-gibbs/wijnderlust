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
    
    @IBOutlet weak var subtitle: UILabel!
    let client = YelpClient()
    
    lazy var dataSource: InspirationDataSource = {
        return InspirationDataSource(data: [], tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIXME: Implement a random selection of a destination on load, then push that into the query, and change the subtitle.
        
        subtitle.text = "Some of our Favourites in London."
        
        tableView.dataSource = dataSource
        
        client.search(withTerm: "wine", at: Coordinate(lat: 51.5033640, long: -0.1276250), categories: baseCategory as! [YelpCategory]) { [weak self] result in
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
                let venueDetailController = segue.destination as! VenueInteriorTableController
                
                //Set custom back image
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                
                if let interiorImage = selectedVenue.photo {
                    venueDetailController.passedVenueImage = interiorImage
                    venueDetailController.venue = selectedVenue
                }
            }
        }
    }
    
    @IBAction func unwindToInspiration(segue: UIStoryboardSegue) {
        
    }

}
