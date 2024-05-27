//
//  CombineCoreLocationView.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct CombineCoreLocationView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        Group {
            if locationViewModel.thereIsAnError {
                Text("Location Service terminated with error: \(locationViewModel.errorMessage)")
            } else {
                Text("Status: \(locationViewModel.statusDescription)")
                HStack {
                    Text("Latitude: \(locationViewModel.latitude)")
                    Text("Longitude: \(locationViewModel.longitude)")
                }
            }
        }
        .padding(.horizontal, 24)
        .task {
            locationViewModel.startUpdating()
        }
    }
}

#Preview {
    CombineCoreLocationView()
}


