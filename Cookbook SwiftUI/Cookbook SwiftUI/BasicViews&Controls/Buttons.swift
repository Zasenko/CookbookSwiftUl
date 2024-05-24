//
//  Buttons.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 23.05.24.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 44) {
                NavigationLink("Buttons"){
                    ButtonView()
                }
                NavigationLink("EditButtons") {
                    EditButtonView()
                }
                NavigationLink("MenuButtons") {
                    MenuButtonView()
                }
                NavigationLink("PasteButtons \n(are only available on macOS)") {
                    PasteButtonView()
                }
                NavigationLink("Details about text") {
                    Text("Very long text that should not be displayed in a single line because it is not good design")
                        .padding()
                        .navigationTitle(Text("Detail"))
                }
            }
            .navigationTitle(Text("Main View"))
        }
    }
}

#Preview {
    Buttons()
}

struct ButtonView: View {
    @State var count = 0
    var body: some View {
        VStack {
            Text("Welcome to your second view")
            Text("Current count value: \(count)")
                .padding()
            Button {
                count += 1
            } label: {
                Text("Tap to Increment count")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(Capsule())
            }
        }.navigationBarTitle("Button View")
    }
}

struct EditButtonView: View {
    @State private var animals = ["Cats", "Dogs", "Goats"]
    var body: some View {
        List{
            ForEach(animals, id: \.self){ animal in
                Text(animal)
            }
            .onDelete(perform: removeAnimal)
        }
        .toolbar {
            EditButton()
        }
        .navigationTitle("EditButtonView")
    }
    func removeAnimal(at offsets: IndexSet){
        animals.remove(atOffsets: offsets)
    }
}

struct MenuButtonView: View {
    var body: some View {
        Menu("Choose a country") {
            Button("Canada") { print("Selected Canada") }
            Button("Mexico") { print("Selected Mexico") }
            Button("USA") { print("Selected USA") }
        }
        .navigationTitle("MenuButtons")
    }
}

// are only available on macOS
struct PasteButtonView: View {
    @State var text  = String()
    var body: some View {
        VStack{
            Text("PasteButton controls how you paste in macOS but is not available in iOS. For more information, check the \"See also\" section of this recipe")
                .padding()
        }
        .navigationTitle("PasteButton")
    }
}
