//
//  SwiftUICoreLocation.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct SwiftUICoreLocation: View {
    
    @ObservedObject private var locationManager: LocationManager
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    var body: some View {
        VStack {
            Text("Status: \(locationManager.status.description)")
            HStack {
                Text("Latitude: \(locationManager.current.latitudeDescription)")
                Text("Longitude: \(locationManager.current.longitudeDescription)")
            }
        }
    }
}

#Preview {
    SwiftUICoreLocation(locationManager: LocationManager())
}
