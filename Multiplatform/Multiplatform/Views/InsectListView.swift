//
//  InsectListView.swift
//  Multiplatform
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct InsectListView: View {
    
    @Environment(InsectData.self) private var insectData: InsectData
    
    var body: some View {
        List {
            ForEach(insectData.insects) { insect in
                NavigationLink(value: insect) {
                    InsectCellView(insect: insect)
                }
            }
        }
        .navigationDestination(for: Insect.self) { insect in
            InsectDetailView(insect: insect)
        }
        .navigationTitle("Insects")
    }
}

#Preview {
    NavigationStack {
        InsectListView()
            .environment(InsectData())
    }
}
