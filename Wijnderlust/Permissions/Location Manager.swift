//
//  Location Manager.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 18/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import CoreLocation

extension Coordinate {
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
}

enum LocationError: Error {
    case unknownError
    case disallowedByUser
    case unableToFindLocation
}

protocol LocationPermissionsDelegate: class {
    func authSucceeded()
    func authFailedWithStatus(_ status: CLAuthorizationStatus)
}

protocol LocationManagerDelegate: class {
    func obtainedCoodinates(_ coordinate: Coordinate)
    func failedWithError(_ error: LocationError)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    //Is authorized
    static var isAuthorized: Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse: return true
        default: return false
        }
    }
    
    //init the delegate to respond to events
    weak var permissionsDelegate: LocationPermissionsDelegate?
    weak var delegate: LocationManagerDelegate?
    
    //Set up the delegate so we can respond to callback events about the user location.
    init(delegate: LocationManagerDelegate?, permissionsDelegate: LocationPermissionsDelegate?) {
        self.delegate = delegate
        self.permissionsDelegate = permissionsDelegate
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    //Asks for permission
    func requestLocationAuthorization() throws {
        //Check whether authorized
        let authStatus = CLLocationManager.authorizationStatus()
        
        //If the user has denied the app, then throw that error.
        if authStatus == .restricted || authStatus == .denied {
            throw LocationError.disallowedByUser
        } else if authStatus == .notDetermined {
            //If they haven't been asked, then request the auth.
            manager.requestWhenInUseAuthorization()
        } else {
            //We are already authorised
            return
        }
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            permissionsDelegate?.authSucceeded()
        } else {
            permissionsDelegate?.authFailedWithStatus(status)
        }
    }
    
    //Can't get location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let error = error as? CLError else {
            delegate?.failedWithError(.unknownError)
            return
        }
        
        switch error.code {
        case .locationUnknown, .network: delegate?.failedWithError(.unableToFindLocation)
        case .denied: delegate?.failedWithError(.disallowedByUser)
        default: return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            delegate?.failedWithError(.unableToFindLocation)
            return
        }
        
        let coordinate = Coordinate(location: location)
        
        delegate?.obtainedCoodinates(coordinate)
    }
}
