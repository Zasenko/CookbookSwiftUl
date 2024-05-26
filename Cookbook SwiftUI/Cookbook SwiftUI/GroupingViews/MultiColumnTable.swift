//
//  MultiColumnTable.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 26.05.24.
//

import SwiftUI

struct MultiColumnTable: View {
    
    static let populationComparator = KeyPathComparator(\City.population, order: .reverse)
    @State private var cities: [City] = City.top20USCities.sorted(using: populationComparator)
    @State private var sortOrder = [populationComparator,
                                    KeyPathComparator(\City.state),
                                    KeyPathComparator(\City.name),
                                    KeyPathComparator(\City.area)]
    @State private var selection = Set<City.ID>()
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isCompact: Bool { horizontalSizeClass == .compact }
    
    var body: some View {
        NavigationStack {
            Table(cities, selection: $selection, sortOrder: $sortOrder) {
                TableColumn("Name", value: \.name) { city in
                    if isCompact {
                        CityRowView(city: city)
                    } else {
                        Text(city.name)
                    }
                }
                TableColumn("State", value: \.state)
                TableColumn("Population", value: \.population) { city in
                    Text(city.formattedPopulation)
                        .font(.body.monospacedDigit())
                        .frame(minWidth: 100, alignment: .trailing)
                }
                .width(max: 150)
                TableColumn("Area", value: \.area) { city in
                    Text(city.formattedArea)
                        .font(.body.monospacedDigit())
                        .frame(minWidth: 100, alignment: .trailing)
                }
                .width(max: 150)
            }
            .navigationTitle("Top 20 US cities")
            .onChange(of: sortOrder) { _, newOrder in
                cities.sort(using: newOrder)
            }
            .onChange(of: selection) {
                print("Selected = { \(Array(selection).sorted().joined(separator: " | ")) }")
}
        }
    }
}

#Preview {
    MultiColumnTable()
}

struct CityRowView: View {
    var city: City
    var body: some View {
        VStack(alignment: .leading) {
            LabeledContent {
                Text(city.state)
            } label: {
                Text(city.name)
                    .font(.title)
            }
            LabeledContent("Population") {
                Text(city.formattedPopulation)
                    .font(.body.monospacedDigit())
            }
            LabeledContent("Area") {
                Text(city.formattedArea)
                    .font(.body.monospacedDigit())
} }
} }

struct City: Identifiable {
    var name: String
    var state: String
    var population: Int
    var area: Measurement<UnitArea>
    var id: String { "\(name), \(state)" }
    
    var formattedArea: String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.minimumFractionDigits = 1
        return formatter.string(from: area)
    }
    var formattedPopulation: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(integerLiteral: population))!
       }
}

extension City {
    static var top20USCities: [City] = [
        City(name: "Austin", state: "Texas", population: 964177, area: Measurement(value: 828.5, unit: UnitArea.squareKilometers)),
        City(name: "Charlotte", state: "North Carolina", population: 879709, area: Measurement(value: 798.5, unit: UnitArea.squareKilometers)),
        City(name: "Chicago", state: "Illinois", population: 2696555, area: Measurement(value: 589.7, unit: UnitArea.squareKilometers)),
        City(name: "Columbus", state: "Ohio", population: 906528, area: Measurement(value: 569.8, unit: UnitArea.squareKilometers)),
        City(name: "Dallas", state: "Texas", population: 1288457, area: Measurement(value: 879.6, unit: UnitArea.squareKilometers)),
        City(name: "Denver", state: "Colorado", population: 711463, area: Measurement(value: 396.5, unit: UnitArea.squareKilometers)),
        City(name: "Fort Worth", state: "Texas", population: 935508, area: Measurement(value: 899.5, unit: UnitArea.squareKilometers)),
        City(name: "Houston", state: "Texas", population: 2288250, area: Measurement(value: 1658.6, unit: UnitArea.squareKilometers)),
        City(name: "Indianapolis", state: "Indiana", population: 882039, area: Measurement(value: 936.5, unit: UnitArea.squareKilometers)),
        City(name: "Jacksonville", state: "Florida", population: 954614, area: Measurement(value: 1935.5, unit: UnitArea.squareKilometers)),
        City(name: "Los Angeles", state: "California", population: 3849297, area: Measurement(value: 1216, unit: UnitArea.squareKilometers)),
        City(name: "New York", state: "New York", population: 8467513, area: Measurement(value: 778.3, unit: UnitArea.squareKilometers)),
        City(name: "Oklahoma City", state: "Oklahoma", population: 687725, area: Measurement(value: 1570.1, unit: UnitArea.squareKilometers)),
        City(name: "Philadelphia", state: "Pennsylvania", population: 1576251, area: Measurement(value: 348.1, unit: UnitArea.squareKilometers)),
        City(name: "Phoenix", state: "Arizona", population: 1624569, area: Measurement(value: 1341.6, unit: UnitArea.squareKilometers)),
        City(name: "San Antonio", state: "Texas", population: 1451853, area: Measurement(value: 1291.9, unit: UnitArea.squareKilometers)),
        City(name: "San Diego", state: "California", population: 1381611, area: Measurement(value: 844.1, unit: UnitArea.squareKilometers)),
        City(name: "San Francisco", state: "California", population: 815201, area: Measurement(value: 121.5, unit: UnitArea.squareKilometers)),
        City(name: "San Jose", state: "California", population: 983489, area: Measurement(value: 461.8, unit: UnitArea.squareKilometers)),
        City(name: "Seattle", state: "Washington", population: 733919, area: Measurement(value: 217, unit: UnitArea.squareKilometers))
    ]
}
