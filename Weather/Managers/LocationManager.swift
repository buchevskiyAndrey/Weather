//
//  LocationManager.swift
//  Weather
//
//  Created by Андрей Бучевский on 16.03.2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var completion: ((String, String) -> Void)?
    
    public func getUserLocation(completion: @escaping ((String, String) -> Void)) {
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.requestLocation()
        self.completion = completion
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let latitude = String(location.coordinate.latitude)
        let longtitude = String(location.coordinate.longitude)
        completion?(latitude, longtitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
