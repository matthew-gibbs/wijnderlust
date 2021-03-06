//
//  AddPlaceController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 08/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class AddPlaceController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var subtitleLabel: UILabel!
    let client = YelpClient()
    var itinerary: Itinerary?
    var location: Coordinate?
    
    lazy var dataSource: AddPlaceDataSource = {
        return AddPlaceDataSource(data: [], tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let itinerary = itinerary else { print("The itinerary is not set yet"); return }
        guard let location = Destinations(rawValue: itinerary.name)?.data.location else { print("This destination doesn't exist"); return }
        self.location = location
        
        searchBar.delegate = self
        tableView.dataSource = dataSource
        
        client.search(withTerm: "wine", at: location, categories: baseCategory as! [YelpCategory]) { [weak self] result in
            switch result {
            case .success(let businesses):
                self?.dataSource.update(with: businesses)
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let itinerary = itinerary else { return }
        subtitleLabel.text = "The Best Places to Drink Wine in \(itinerary.name)."
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
    
    var searchTerm: String = ""
    
    //MARK: Search Bar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchTerm = searchBar.text {
            self.searchTerm = searchTerm
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        client.search(withTerm: self.searchTerm, at: location!, radius: 40000) { [weak self] result in
            switch result {
            case .success(let venues):
                searchBar.resignFirstResponder()
                self?.dataSource.update(with: venues)
                self?.tableView.reloadData()
                
            case .failure(let error):
                self?.dataSource.update(with: [])
                self?.tableView.reloadData()
                switch error {
                case .noResults:
                    let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self!.tableView.bounds.size.width, height: self!.tableView.bounds.size.height))
                    noDataLabel.text          = "We can't find anything for that term! :("
                    noDataLabel.textColor     = UIColor.init(displayP3Red: 142/255.0, green: 142/255.0, blue: 142/255.0, alpha: 1)
                    noDataLabel.textAlignment = .center
                    self?.tableView.backgroundView  = noDataLabel
                    self?.tableView.separatorStyle  = .none
                default:
                    let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self!.tableView.bounds.size.width, height: self!.tableView.bounds.size.height))
                    noDataLabel.text          = "Something broke - give it another whirl. Sorry!"
                    noDataLabel.textColor     = UIColor.init(displayP3Red: 142/255.0, green: 142/255.0, blue: 142/255.0, alpha: 1)
                    noDataLabel.textAlignment = .center
                    self?.tableView.backgroundView  = noDataLabel
                    self?.tableView.separatorStyle  = .none
                }
            }
        }
    }

}
