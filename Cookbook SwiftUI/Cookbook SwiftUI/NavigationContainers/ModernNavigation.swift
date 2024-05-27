//
//  ModernNavigation.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 26.05.24.
//

import SwiftUI

struct ModernNavigation: View {
    
    @StateObject private var navigation = Navigation()
    @StateObject private var storage = Storage(food: FoodNav.samples)
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            List {
                Section("Categories") {
                    ForEach(Category.allCases) { category in
                        NavigationLink(category.name, value: category)
                    }
                }
                Section("Favorites") {
                    if storage.favorites.isEmpty {
                        Text("No favorites added")
                    } else {
                        ForEach(storage.favorites) { food in
                            NavigationLink(value: food) {
                                FoodRowView(food: food)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Food")
            .navigationDestination(for: Category.self) { category in
                FoodCategoryView(category: category)
                    .environmentObject(storage)
            }
            .navigationDestination(for: FoodNav.self) { food in
                FoodView(food: food)
                    .environmentObject(navigation)
                    .environmentObject(storage)
            }
        }
    }
    
//    var body: some View {
//        NavigationStack(path: $navigation.path) {
//            List(Category.allCases) { category in
//                Section(category.name) {
//                    ForEach(Category.allCases) { category in
//                                        NavigationLink(category.name, value: category)
//                    }
//                }
//            }
//            .navigationTitle("My Food")
//            .navigationDestination(for: FoodNav.self) { food in
//                FoodView(food: food)
//                    .environmentObject(navigation)
//                    .environmentObject(storage)
//            }
//        }
//    }
}

#Preview {
    ModernNavigation()
}

struct FoodCategoryView: View {
    
    @EnvironmentObject private var storage: Storage
    var category: Category
    
    var body: some View {
        List(storage.food(in: category)) { food in
            NavigationLink(value: food) {
                FoodRowView(food: food)
            }
        }
        .navigationTitle(category.name)
    }
}

#Preview("FoodCategoryView") {
    NavigationStack {
        FoodCategoryView(category: .fruit)
            .environmentObject(Storage(food: FoodNav.samples))
    }
}

struct FoodRowView: View {
    var food: FoodNav
    var body: some View {
        LabeledContent {
            Image(food.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
        } label: {
            Text(food.name)
        }
    }
}
struct FoodView: View {
    
    @EnvironmentObject private var storage: Storage
    @EnvironmentObject private var navigation: Navigation
    
    var food: FoodNav
    
    var body: some View {
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
                            NavigationLink(value: recent) {
                                FoodRowView(food: recent)
                            }
                            .disabled(recent == food)
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
        .navigationTitle(food.name)
        .toolbar {
            Button {
                storage.toggleFavorite(food)
            } label: {
                if storage.isFavorite(food) {
                    Image(systemName: "minus.square")
                } else {
                    Image(systemName: "plus.square")
                }
            }
            Button {
                navigation.popToRoot()
            } label: {
                Image(systemName: "list.bullet")
            }
        }
        .onDisappear {
            storage.addRecent(food)
        }
    }
}

struct CategoryView: View {
    
    var category: Category
    
    var color: Color {
        switch category {
        case .fruit: .yellow
        case .meat: .red
        case .vegetable: .green
        }
    }
    
    var body: some View {
        Text(category.name)
            .foregroundStyle(.white)
            .padding(.all, 8)
            .background(color)
            .clipShape(Capsule())
    }
}

final class Storage: ObservableObject {
    
    @Published var food: [FoodNav]
    @Published var recents: [FoodNav]
    @Published var favorites: [FoodNav]
    
    init(food: [FoodNav], recents: [FoodNav] = [], favorites: [FoodNav] = []) {
        self.food = food
        self.recents = recents
        self.favorites = favorites
    }
    
    func food(in category: Category) -> [FoodNav] {
        food
            .filter { $0.category == category }
            .sorted { $0.name < $1.name }
    }
    
    func addRecent(_ food: FoodNav) {
        if !recents.contains(food) {
            recents = [food] + Array(recents.prefix(2))
        }
    }
    
    func isFavorite(_ food: FoodNav) -> Bool {
        favorites.contains(food)
    }
    func toggleFavorite(_ food: FoodNav) {
        if isFavorite(food) {
            favorites.removeAll { $0.id == food.id }
        } else {
            favorites.append(food)
        }
    }
}

final class Navigation: ObservableObject {
    
   // @Published var path = [FoodNav]()
    @Published var path: NavigationPath = .init()

    func popToRoot () {
        path = .init()
    }
}

enum Category: Int, Identifiable, CaseIterable, Hashable {
    case meat
    case vegetable
    case fruit
    
    var id: Int { rawValue }
    var name: String {
        switch self {
        case .meat: "Meat"
        case .vegetable: "Vegetable"
        case .fruit: "Fruit"
        }
    }
}

struct FoodNav: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var category: Category
}

extension FoodNav {
    static let samples: [FoodNav] = [
        FoodNav(name: "Apple", category: .fruit),
        FoodNav(name: "Pear", category: .fruit),
        FoodNav(name: "Orange", category: .fruit),
        FoodNav(name: "Lemon", category: .fruit),
        FoodNav(name: "Strawberry", category: .fruit),
        FoodNav(name: "Plum", category: .fruit),
        FoodNav(name: "Banana", category: .fruit),
        FoodNav(name: "Melon", category: .fruit),
        FoodNav(name: "Watermelon", category: .fruit),
        FoodNav(name: "Peach", category: .fruit),
        FoodNav(name: "Pork", category: .meat),
        FoodNav(name: "Beef", category: .meat),
        FoodNav(name: "Lamb", category: .meat),
        FoodNav(name: "Goat", category: .meat),
        FoodNav(name: "Chicken", category: .meat),
        FoodNav(name: "Turkey", category: .meat),
        FoodNav(name: "Fish", category: .meat),
        FoodNav(name: "Crab", category: .meat),
        FoodNav(name: "Lobster", category: .meat),
        FoodNav(name: "Shrimp", category: .meat),
        FoodNav(name: "Carrot", category: .vegetable),
        FoodNav(name: "Lettuce", category: .vegetable),
        FoodNav(name: "Tomato", category: .vegetable),
        FoodNav(name: "Onion", category: .vegetable),
        FoodNav(name: "Broccoli", category: .vegetable),
        FoodNav(name: "Cauliflower", category: .vegetable),
        FoodNav(name: "Eggplant", category: .vegetable),
        FoodNav(name: "Swiss Chard", category: .vegetable),
        FoodNav(name: "Spinach", category: .vegetable),
        FoodNav(name: "Zucchini", category: .vegetable)
    ]
}
