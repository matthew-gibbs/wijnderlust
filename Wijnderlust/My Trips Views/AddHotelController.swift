//
//  AddHotelController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import Firebase

class AddHotelController: UITableViewController, UISearchBarDelegate  {
    var itinerary: Itinerary?
    let client = YelpClient()
    var hotels: [Venue] = []
    var location: Coordinate?
    let ref = Database.database().reference()
    let userId = UserDefaults.standard.getCurrentUserId()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let itinerary = itinerary else { print("The itinerary is not set yet"); return }
        guard let location = Destinations(rawValue: itinerary.name)?.data.location else { print("This destination doesn't exist"); return }
        self.location = location
        
        searchBar.delegate = self
        
        client.search(withTerm: "Hotel", at: location, radius: 40000) { [weak self] result in
            switch result {
            case .success(let hotels):
                self?.hotels = hotels
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        print(location)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hotels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelListCell", for: indexPath) as! HotelListCell
        
        let currentVenue = hotels[indexPath.row]

        cell.configure(with: currentVenue)

        return cell
    }
 
    //MARK: Selecting Hotel.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let hotelCell = cell as! HotelListCell
            guard let hotel = hotelCell.hotel else { return }

            //Initialise the alert
            let alert = UIAlertController(title: "Add Hotel", message: "Do you want to add \(hotel.name) to your itinerary?", preferredStyle: .alert)
            
            //Success Save Action
            let saveChangesAction = UIAlertAction(title: "Yes!", style: .default) { (alert: UIAlertAction!) -> Void in
                let itineraryId = self.itinerary!.id
                
                self.ref.child("users/\(self.userId)/itineraries/\(itineraryId)/hotelId").setValue(hotel.id)
                
                self.dismiss(animated: true)
            }
            //Cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
            }
            
            alert.addAction(saveChangesAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    

    
    //MARK: Search Bar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTerm = searchBar.text else { return }
        
        client.search(withTerm: searchTerm, at: location!, radius: 40000) { [weak self] result in
            switch result {
            case .success(let hotels):
                self?.tableView.backgroundView = nil
                self?.tableView.separatorStyle = .singleLine
                self?.hotels = hotels
                self?.tableView.reloadData()
                
            case .failure(let error):
                self?.hotels = []
                self?.tableView.reloadData()
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self!.tableView.bounds.size.width, height: self!.tableView.bounds.size.height))
                noDataLabel.text          = "We can't find anything for that term! :("
                noDataLabel.textColor     = UIColor.init(displayP3Red: 142/255.0, green: 142/255.0, blue: 142/255.0, alpha: 1)
                noDataLabel.textAlignment = .center
                self?.tableView.backgroundView  = noDataLabel
                self?.tableView.separatorStyle  = .none
                print(error)
            }
        }
    }
}


