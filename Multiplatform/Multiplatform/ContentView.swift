//
//  ContentView.swift
//  Multiplatform
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(InsectData.self) private var insectData: InsectData
    
    var body: some View {
        NavigationStack {
            InsectListView()
        }
    }
}

#Preview {
    ContentView()
        .environment(InsectData())
}
