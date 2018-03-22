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
    let randomLocationIndex = random(0...Int(Destinations.count))
    
    lazy var dataSource: InspirationDataSource = {
        return InspirationDataSource(data: [], tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomLocation = Destinations.allDestinations[randomLocationIndex]
        
        print(randomLocation)
        
        subtitle.text = "Some of our Favourites in \(randomLocation.name)."
        
        tableView.dataSource = dataSource
        
        client.search(withTerm: "wine", at: randomLocation.location, categories: baseCategory as! [YelpCategory]) { [weak self] result in
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

//Random Number Generator
func random(_ range:ClosedRange<Int>) -> Int
{
    return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
}
