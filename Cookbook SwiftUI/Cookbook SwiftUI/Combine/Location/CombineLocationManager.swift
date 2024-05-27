//
//  CombineLocationManager.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import CoreLocation
import Combine

class CombineLocationManager: NSObject {
    enum LocationError: String, Error {
        case restricted
        case denied
        case unknown
    }
    
    private let locationManager = CLLocationManager()
    
    let statusPublisher = PassthroughSubject<CLAuthorizationStatus, LocationError>()
    let locationPublisher = PassthroughSubject<CLLocation?, Never>()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
}

extension CombineLocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .restricted:
             statusPublisher.send(completion: .failure(.restricted))
        case .denied:
             statusPublisher.send(completion: .failure(.denied))
        case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
             statusPublisher.send(manager.authorizationStatus)
        @unknown default:
             statusPublisher.send(completion: .failure(.unknown))
        }
}
    func locationManager(_ manager: CLLocationManager, didUpdateLocations
                         locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationPublisher.send(location)
    }
}
