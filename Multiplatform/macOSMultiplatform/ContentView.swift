//
//  ContentView.swift
//  macOSMultiplatform
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(InsectData.self) private var insectData: InsectData
    
    var body: some View {
        NavigationSplitView {
                MacInsectListView()
                    .navigationSplitViewColumnWidth(min: 360, ideal: 400, max: 500)
        } detail: {
            ContentUnavailableView("Choose an insect from the list", systemImage: "hand.point.up.left")
        }
    }
}

#Preview {
    ContentView()
        .environment(InsectData())
}
