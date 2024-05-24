//
//  StaticList.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 24.05.24.
//

import SwiftUI

struct WeatherInfo: Identifiable {
    var id = UUID()
    var image: String
    var temp: Int
    var city: String
}

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
}

struct StaticList: View {
    
    @State private var todos = [
        TodoItem(title: "Eat"),
        TodoItem(title: "Sleep"),
        TodoItem(title: "Code")
    ]
    
    @State private var weatherData: [WeatherInfo] = [
        WeatherInfo(image: "snow", temp: 5, city:"New York"),
        WeatherInfo(image: "cloud", temp:5, city:"Kansas City"),
        WeatherInfo(image: "sun.max", temp: 80, city:"San Francisco"),
        WeatherInfo(image: "snow", temp: 5, city:"Chicago"),
        WeatherInfo(image: "cloud.rain", temp: 49, city:"Washington DC"),
        WeatherInfo(image: "cloud.heavyrain", temp: 60, city:"Seattle"),
        WeatherInfo(image: "sun.min", temp: 75, city:"Baltimore"),
        WeatherInfo(image: "sun.dust", temp: 65, city:"Austin"),
        WeatherInfo(image: "sunset", temp: 78, city:"Houston"),
        WeatherInfo(image: "moon", temp: 80, city:"Boston"),
        WeatherInfo(image: "moon.circle", temp: 45, city:"Denver"),
        WeatherInfo(image: "cloud.snow", temp: 8, city:"Philadelphia"),
        WeatherInfo(image: "cloud.hail", temp: 5, city:"Memphis"),
        WeatherInfo(image: "cloud.sleet", temp:5, city:"Nashville"),
        WeatherInfo(image: "sun.max", temp: 80, city:"San Francisco"),
        WeatherInfo(image: "cloud.sun", temp: 5, city:"Atlanta"),
        WeatherInfo(image: "wind", temp: 88, city:"Las Vegas"),
        WeatherInfo(image: "cloud.rain", temp: 60, city:"Phoenix"),
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach($todos) { $todo in
                        TextField("Todo Item", text: $todo.title)
                    }
                } header: {
                   Text("Editable Lists Fields")
                }
                
                ForEach(weatherData) {weather in
                    WeatherRow(weather: weather)
                }
                .onMove(perform: moveRow)
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add") {
                    addItemToRow()
                }
                EditButton()
                
            }
        }
    }
    
    private func addItemToRow() {
        self.weatherData.append(WeatherInfo(image: "moon", temp: Int.random(in: 10 ..< 50), city: "New City"))
    }
    
    private func moveRow(source: IndexSet, destination: Int) {
        weatherData.move(fromOffsets: source, toOffset: destination)
    }
    
    private func deleteItem(at indexSet: IndexSet){
        weatherData.remove(atOffsets: indexSet)
    }
}

#Preview {
    StaticList()
}

struct WeatherRow: View {
    var weather: WeatherInfo
    var body: some View {
        HStack {
            Image(systemName: weather.image)
                .frame(width: 50, alignment: .leading)
            Text("\(weather.temp)°F")
                .frame(width: 80, alignment: .leading)
            Text(weather.city)
        }
        .font(.system(size: 25))
        .padding()
    }
}
