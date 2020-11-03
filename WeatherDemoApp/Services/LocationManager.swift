//
//  LocationManager.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import Foundation
import CoreLocation

class LocationManager {
    
    static let shared = LocationManager()
    
    private init() {}
    
    func getCoordinateFrom(city: String,
                           completion: @escaping(_ coordinate: CLLocationCoordinate2D?,
                                                 _ error: Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { (placemark, error) in
            DispatchQueue.main.async {
                completion(placemark?.first?.location?.coordinate, error)
            }
        }
    }
}
