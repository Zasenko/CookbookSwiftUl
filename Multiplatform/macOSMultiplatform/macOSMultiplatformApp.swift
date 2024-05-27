//
//  macOSMultiplatformApp.swift
//  macOSMultiplatform
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

@main
struct macOSMultiplatformApp: App {
    
    @State private var insectData = InsectData()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(insectData)
        }
    }
}
