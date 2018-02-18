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
    
    var userLocation: Coordinate?

    //Outlets
    @IBOutlet weak var aroundMeMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isAuthorizedForLocation() {
            locationManager.requestLocation()
        } else {
            requestLocationPermissions()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    func requestLocationPermissions() {
        do {
            try locationManager.requestLocationAuthorization()
        } catch LocationError.disallowedByUser {
            //Show Alert to users
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
    }
    
    //MARK: Location Manager Delegate
    func obtainedCoodinates(_ coordinate: Coordinate) {
        self.userLocation = coordinate
        mapSetup()
        print(coordinate)
    }
    
    func failedWithError(_ error: LocationError) {
        //FIXME: Handle the error
    }
    
    //MARK: Map Setup
    func mapSetup() {
        guard let userLocation = userLocation else { return }
        adjustMap(with: userLocation, on: aroundMeMap)
    }

}
