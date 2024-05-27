//
//  MultiplatformApp.swift
//  Multiplatform
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

@main
struct MultiplatformApp: App {
    
    @State private var insectData = InsectData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(insectData)
        }
    }
}
