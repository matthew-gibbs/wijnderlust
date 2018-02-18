//
//  AroundMeController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 18/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AroundMeController: UIViewController, LocationPermissionsDelegate, LocationManagerDelegate {
    
    //Create a Location Manager
    lazy var locationManager: LocationManager = {
        return LocationManager(delegate: self, permissionsDelegate: self)
    }()
    
    //Create a api client
    let client = YelpClient()
    
    //Store User location when it exists
    var userLocation: Coordinate?
    
    //Store nearby venues when they exist
    var nearbyVenues: [Venue]?
    
    //If the user is searching
    var searchTerm: String = "wine"

    
    //Outlets
    @IBOutlet weak var aroundMeMap: MKMapView!
    @IBOutlet weak var searchLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchLabel.text = "Great Places to Drink Wine Near You..."
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isAuthorizedForLocation() {
            locationManager.requestLocation()
        } else {
            requestLocationPermissions()
        }
    }
    
    
    //MARK: Location Permissions
    func requestLocationPermissions() {
        do {
            try locationManager.requestLocationAuthorization()
        } catch LocationError.disallowedByUser {
            showLinkToSettingsAlert()
        } catch let error {
            print("location error: \(error.localizedDescription)")
        }
    }
    
    //MARK: Location Permissions Delegate
    func authSucceeded() {
        locationManager.requestLocation()
    }
    
    func authFailedWithStatus(_ status: CLAuthorizationStatus) {
        //FIXME: Do something else
        print(status)
    }
    
    //MARK: Location Manager Delegate
    func obtainedCoodinates(_ coordinate: Coordinate) {
        self.userLocation = coordinate
        getVenues(coordinate)
        print(coordinate)
    }
    
    //If they haven't enabled location.
    func showLinkToSettingsAlert() {
        let alertController = UIAlertController(title: "We need to know where you are!",
                                                message: "In order to show great wine around you, we first need you to turn on your location for this app. You can do this in settings by following the button below.",
                                                preferredStyle: .alert)
        
        let changeSettingsAction = UIAlertAction(title: "Enable Location", style: .default) { (alertAction) in
            if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(appSettings as URL)
            }
        }
        let cancelAction = UIAlertAction(title: "Don't Enable Location", style: .destructive)
        
        alertController.addAction(changeSettingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func failedWithError(_ error: LocationError) {
        //FIXME: Handle the error
        print(error)
    }
    
    //MARK: Get Nearby Venues
    func getVenues(_ coordinate: Coordinate) {
        client.search(withTerm: searchTerm, at: coordinate, radius: 3000) { [weak self] result in
            switch result {
            case .success(let businesses):
                self?.nearbyVenues = businesses
                self?.mapSetup(coordinate: coordinate, venues: businesses)
            case .failure(let error):
                self?.dataError(error)
                print(error)
            }
        }
    }
    
    //MARK: Map Setup
    func mapSetup(coordinate: Coordinate, venues: [Venue]) {
        aroundMeMap.removeAnnotations(aroundMeMap.annotations)
        
        adjustMap(with: coordinate, on: aroundMeMap)
        for venue in venues {
            let pin = VenuePin(title: venue.name, subtitle: "\(venue.rating) ⭐️", coordinate: venue.location)
            aroundMeMap.addAnnotation(pin)
        }
    }
    
    //MARK: Unwind Segue
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        let source = segue.source as? AroundMeSearchController
        guard let userSearch = source?.searchField.text else { return }
        let trimmedString = userSearch.trimmingCharacters(in: .whitespacesAndNewlines)
        searchTerm = trimmedString
        searchLabel.text = "Showing results for \(searchTerm)..."
    }

    
    //MARK: Handling Errors
    func dataError(_ errorType: APIError) {
        switch errorType {
        case .noResults:
            self.showAlertWith(title: "No Results!", message: "We can't find anything for '\(searchTerm)' near you. Try something else.");
            resetMapView()
        default:
            self.showAlertWith(title: "\(errorType)", message: "\(errorType.localizedDescription)")
            resetMapView()
        }
    }
    
    func resetMapView(){
        guard let coordinate = userLocation else { return }
        searchTerm = "wine"
        getVenues(coordinate)
        searchLabel.text = "Great Places to Drink Wine Near You..."
    }
    
}
