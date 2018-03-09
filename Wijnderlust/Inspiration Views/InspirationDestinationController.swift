//
//  InspirationDestinationController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 09/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class InspirationDestinationController: UITableViewController {
    @IBOutlet weak var searchBar: UITextField!
    
    @IBAction func searchChanged(_ sender: Any) {
        guard let search = searchBar.text?.capitalized else { return }
        
        if search.isEmpty {
            destinations = Destinations.allDestinations
            tableView.reloadData()
            return
        }
        
        print(search)
        
        let filteredDestinations = destinations.filter { (destination) -> Bool in
            destination.name.contains(search)
        }
        
        destinations = filteredDestinations
        tableView.reloadData()
    }
    
    var destinations = Destinations.allDestinations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.underlined()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DestinationCell", for: indexPath) as! DestinationCell
        
        let destination = destinations[indexPath.row]
        
        cell.configure(with: destination)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "destinationToInspirationResults" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedDestination = destinations[selectedIndexPath.row]
                let destinationInspirationController = segue.destination as! DestinationInspirationController
                
                print(selectedDestination)
                
                destinationInspirationController.destination = selectedDestination
                
            }
        }
    }
}
