//
//  SearchableList.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 24.05.24.
//

import SwiftUI

struct SearchableList: View {
    
    enum FruitSearchScope: Hashable {
        case all
        case food(Food.Category)
    }
    
    @State private var scope: FruitSearchScope = .all
    @State private var searchText = ""
    let food: [Food] = Food.sampleFood
    
    //   var searchResults: [Food] {
    //        if searchText.isEmpty {
    //            return food
    //        } else {
    //            return food.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    //        }
    
    var searchResults: [Food] {
        var food: [Food] = self.food
        if case let .food(category) = scope {
            food = food.filter { $0.category == category }
        }
        if !searchText.isEmpty {
            food = food.filter { $0.name.lowercased().contains(searchText.lowercased())}
        }
        return food
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { food in
                    LabeledContent(food.name) {
                        Text("\(food.category.rawValue)")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for a food")
            .searchScopes($scope, activation: .onSearchPresentation) {
                Text("All").tag(FruitSearchScope.all)
                Text("Fruit").tag(FruitSearchScope.food(.fruit))
                Text("Meat").tag(FruitSearchScope.food(.meat))
                Text("Vegetable").tag(FruitSearchScope.food(.vegetable))
            }
            .navigationTitle("Foods")
        }
    }
}

#Preview {
    SearchableList()
}

struct Food: Hashable {
    
    enum Category: String {
        case fruit
        case meat
        case vegetable
    }
    
    var name: String
    var category: Category
}


extension Food {
    static let sampleFood: [Food] = [
        Food(name: "Apple", category: .fruit),
        Food(name: "Pear", category: .fruit),
        Food(name: "Orange", category: .fruit),
        Food(name: "Lemon", category: .fruit),
        Food(name: "Strawberry", category: .fruit),
        Food(name: "Plum", category: .fruit),
        Food(name: "Banana", category: .fruit),
        Food(name: "Melon", category: .fruit),
        Food(name: "Watermelon", category: .fruit),
        Food(name: "Peach", category: .fruit),
        Food(name: "Pork", category: .meat),
        Food(name: "Beef", category: .meat),
        Food(name: "Lamb", category: .meat),
        Food(name: "Goat", category: .meat),
        Food(name: "Chicken", category: .meat),
        Food(name: "Turkey", category: .meat),
        Food(name: "Fish", category: .meat),
        Food(name: "Crab", category: .meat),
        Food(name: "Lobster", category: .meat),
        Food(name: "Shrimp", category: .meat),
        Food(name: "Carrot", category: .vegetable),
        Food(name: "Lettuce", category: .vegetable),
        Food(name: "Tomato", category: .vegetable),
        Food(name: "Onion", category: .vegetable),
        Food(name: "Broccoli", category: .vegetable),
        Food(name: "Cauliflower", category: .vegetable),
        Food(name: "Eggplant", category: .vegetable),
        Food(name: "Swiss Chard", category: .vegetable),
        Food(name: "Spinach", category: .vegetable),
        Food(name: "Zucchini", category: .vegetable),
    ]
}
