//
//  LocationManager.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var status: CLAuthorizationStatus?
    @Published var current: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = 10
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        current = location
    }
}

extension Optional where Wrapped == CLAuthorizationStatus {
    var description: String {
        guard let self else { return "unknown" }
        switch self {
        case .notDetermined:
            return "notDetermined"
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
        case .authorizedAlways:
            return "authorizedAlways"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        @unknown default:
            return "unknown"
        }
    }
}

extension Optional where Wrapped == CLLocation {
    var latitudeDescription: String {
        guard let latitude = self?.coordinate.latitude else { 
            return "-"
        }
        return String(format: "%.3f", latitude)
    }
    var longitudeDescription: String {
        guard let longitude = self?.coordinate.longitude else {
            return "-"
        }
        return String(format: "%.3f", longitude)
    }
}
