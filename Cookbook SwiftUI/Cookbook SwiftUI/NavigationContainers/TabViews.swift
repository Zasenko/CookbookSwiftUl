//
//  TabViews.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct TabViews: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Left Tab. Tap to switch to right")
                .onTapGesture {
                    selectedTab = 1
                }
                .tabItem {
                    Label("Left", systemImage: "l.circle.fill")
                }
                .tag(0)
            Text("Right Tab. Tap to switch to left")
                .onTapGesture {
                    selectedTab = 0
                }
                .tabItem {
                    Label("Right",systemImage: "r.circle.fill")
                }
                .tag(1)
        }
//        TabView {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//            CurrenciesView()
//                .tabItem {
//                    Label("Currencies", systemImage: "coloncurrencysign.circle.fill")
//                }
//        }
    }
}

#Preview {
    TabViews()
}

struct HomeView: View {
    let games = ["Doom", "Final F","Cyberpunk", "avengers", "animal trivia", "sudoku", "snakes and ladders", "Power rangers", "ultimate frisbee", "football", "soccer", "much more"]
    
    init() {
        print("init HomeView")
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(games, id: \.self){ game in
                    Text(game).padding()
                }
            }.navigationTitle("Best Games for 2021")
        }
    }
}

struct Currency: Identifiable {
    let id = UUID()
    var name:String
    var image:String
}

extension Currency {
    static var currencies = [
        Currency(name: "Dollar", image: "dollarsign.circle.fill"),
        Currency(name: "Sterling", image: "sterlingsign.circle.fill"),
        Currency(name: "Euro", image: "eurosign.circle.fill"),
        Currency(name: "Yen", image: "yensign.circle.fill"),
        Currency(name: "Naira", image: "nairasign.circle.fill")
    ]
}

struct CurrenciesView: View {
    
    init() {
        print("init CurrenciesView")
    }
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(Currency.currencies) { currency in
                    HStack {
                            Text(currency.name)
                            Spacer()
                            Image(systemName: currency.image)
                        }
                        .font(Font.system(size: 32, design: .default))
                        .padding()
                        .task {
                            print("-CurrenciesView currency \(currency.id) task")
                        }
                }
            }
            .navigationTitle("Currencies")
        }
        .task {
            print("-CurrenciesView task")
        }
    }
}
