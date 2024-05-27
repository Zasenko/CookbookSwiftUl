//
//  MacInsectListView.swift
//  macOSMultiplatform
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct MacInsectListView: View {
    
    @Environment(InsectData.self) private var insectData: InsectData
    
    var body: some View {
        List(insectData.insects) { insect in
            NavigationLink(value: insect) {
                MacInsectCellView(insect: insect)
            }
        }
        .navigationDestination(for: Insect.self) { insect in
            ScrollView {
                InsectDetailView(insect: insect)
            }
        }
        .navigationTitle("Insects")
        .listStyle(.sidebar)
    }
}

#Preview {
    NavigationStack {
        MacInsectListView()
            .environment(InsectData())
    }
}
