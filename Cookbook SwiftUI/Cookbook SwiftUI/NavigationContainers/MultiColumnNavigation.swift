//
//  MultiColumnNavigation.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct MultiColumnNavigation: View {
    
    @StateObject private var storage = Storage(food: FoodNav.samples)
    @State private var selectedCategory: Category?
    @State private var selectedFood: FoodNav?
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedCategory) {
                ForEach(Category.allCases) { category in
                    NavigationLink(category.name, value: category)
                }
            }
            .navigationTitle("Categories")
        } content: {
            FoodCategoryView2(selectedCategory: $selectedCategory,
                              selectedFood: $selectedFood)
            .environmentObject(storage)
            .onChange(of: selectedCategory, initial: false) {
                columnVisibility = .doubleColumn
            }
        } detail: {
            FoodView2(selectedCategory: $selectedCategory, selectedFood:
                        $selectedFood)
            .environmentObject(storage)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    MultiColumnNavigation()
        .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
}

struct FoodView2: View {
    @EnvironmentObject private var storage: Storage
    @Binding var selectedCategory: Category?
    @Binding var selectedFood: FoodNav?
    var body: some View {
        if let food  = selectedFood {
            VStack(alignment: .leading) {
                CategoryView(category: food.category)
                    .padding(.leading)
                Image(food.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                if storage.recents.isEmpty {
                    Spacer()
                } else {
                    List {
                        Section("Recents") {
                            ForEach(storage.recents) { recent in
                                FoodRowView(food: recent)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if recent != food {
                                            selectedFood = recent
                                            selectedCategory = recent.category
                                        }
                                    }
                            }
                        }
                    }
                    .listStyle(.grouped)
                }
            }
            .navigationTitle(food.name)
            .onChange(of: food) { oldValue, newValue in
                storage.addRecent(oldValue)
            }
            .onDisappear() { [selectedFood] in
                storage.addRecent(selectedFood!)
            }
        } else {
            Text("Choose a type of food")
        }
    }
}

struct FoodCategoryView2: View {
    @EnvironmentObject private var storage: Storage
    @Binding var selectedCategory: Category?
    @Binding var selectedFood: FoodNav?
    var body: some View {
        if let selectedCategory {
            List(storage.food(in: selectedCategory), selection:
                    $selectedFood) { food in
                NavigationLink(value: food) {
                    FoodRowView(food: food)
                }
            }
                    .navigationTitle(selectedCategory.name)
        } else {
            Text("Choose a category")
        }
    }
}
