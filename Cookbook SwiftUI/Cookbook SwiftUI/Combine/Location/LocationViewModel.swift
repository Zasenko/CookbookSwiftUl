//
//  LocationViewModel.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI
import CoreLocation
import Combine

class LocationViewModel: ObservableObject {
    
    @Published private var status: CLAuthorizationStatus = .notDetermined
    @Published private var currentLocation: CLLocation?
    @Published var errorMessage = ""
    
    private let locationManager = CombineLocationManager()
    
    var thereIsAnError: Bool {
        !errorMessage.isEmpty
    }
    var latitude: String {
        currentLocation.latitudeDescription
    }
    var longitude: String {
        currentLocation.longitudeDescription
    }
    var statusDescription: String {
        switch status {
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
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        locationManager.statusPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.rawValue
                }
            } receiveValue: { self.status = $0}
            .store(in: &cancellableSet)
        
        locationManager.locationPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
        
            .removeDuplicates(by: lessThanOneMeter)
            .assign(to: \.currentLocation, on: self)
            .store(in: &cancellableSet)
    }


    func startUpdating() {
       locationManager.start()
    }
    
    private func lessThanOneMeter(_ lhs: CLLocation?, _ rhs: CLLocation?)
    -> Bool {
        if lhs == nil && rhs == nil {
            return true
        }
        guard let lhs, let rhs else {
            return false
        }
        return lhs.distance(from: rhs) < 1
    }
    
}
