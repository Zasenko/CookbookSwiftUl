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
                chap3
                chap4
                chap5
                chap7
            }
            .listStyle(.grouped)
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
    
    var chap3: some View {
        Section {
            NavigationLink("Lazy Stacks") {
                LazyStacks()
            }
            NavigationLink("Lazy Grids") {
                LazyGrids()
            }
            NavigationLink("ScrollView Readers") {
                ScrollViewReaders()
            }
            NavigationLink("Expanding Lists") {
                ExpandingLists()
            }
            NavigationLink("Disclosure Groups") {
                DisclosureGroups()
            }
            NavigationLink("ToDoList for Widgets") {
                ToDoList()
            }
        } header: {
            Text("Advanced Components")
        }
    }
    
    var chap4: some View {
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
            Text("Preview")
        }
    }
    
    var chap5: some View {
        Section {
            NavigationLink("Sign Up View") {
                SignUpView()
            }
            NavigationLink("Focus And Submit") {
                FocusAndSubmit()
            }
            NavigationLink("Multi Column Table") {
                MultiColumnTable()
            }
            NavigationLink("Two Dimensional Layout") {
                TwoDimensionalLayout()
            }
        } header: {
            Text("New Components and Grouping Views with Container Views")
        }
    }
    
    var chap7: some View {
        Section {
            NavigationLink("Simple Navigation") {
                SimpleNavigation()
            }
            NavigationLink("Modern Navigation") {
                ModernNavigation()
            }
            NavigationLink("Multi-column Navigation") {
                MultiColumnNavigation()
            }
            NavigationLink("TabViews") {
                TabViews()
            }
            
            
        } header: {
            Text("Navigation Containers")
        }
    }
    
}

#Preview {
    ContentView()
}
