//
//  ContentView.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 23.05.24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            List {
                chap1
                chap2
            }
            .listStyle(.grouped)
            .navigationTitle("Continents and Countries")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var chap1: some View {
        Section {
            NavigationLink("The Stacks") {
                TheStacks()
            }
            NavigationLink("Formatted Text") {
                FormattedText()
            }
            NavigationLink("Buttons") {
                Buttons()
            }
            NavigationLink("Pickers") {
                Pickers()
            }
            NavigationLink("View Modifiers") {
                ViewModifiers()
            }
            NavigationLink("View Builder") {
                ViewBuilders()
            }
            NavigationLink("SFSymbols") {
                SFSymbols()
            }
            NavigationLink("UIKit To SwiftUI") {
                UIKitToSwiftUI()
            }
            NavigationLink("More Views And Controls") {
                MoreViewsAndControls()
            }
        } header: {
            Text("Basic Views & Controls")
        }
    }
    
    var chap2: some View {
        Section {
            NavigationLink("Scroll View") {
                ScrollViews()
            }
            NavigationLink("Static List") {
                StaticList()
            }
            NavigationLink("Searchable List") {
                SearchableList()
            }
        } header: {
            Text("Scrollable Content")
        }
    }
}

#Preview {
    ContentView()
}
