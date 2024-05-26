//
//  FocusAndSubmit.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 26.05.24.
//

import SwiftUI

struct FocusAndSubmit: View {
    
    enum AddressField {
           case streetName
           case city
           case state
           case zipCode
   }
    
    @State private var streetName = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipCode = ""
    @FocusState private var currentFocus: AddressField?
    
    @State private var description = ""
        @FocusState private var isFocused: Bool
    
    var body: some View {
        Form {
            Section("single FocusState") {
                TextField("Enter the description", text: $description)
                            .focused($isFocused)
                        Button("Hide keyboard") {
                            isFocused = false
                }
            }
            
            Section("FocusState is enum") {
                TextField("Address", text: $streetName)
                    .focused($currentFocus, equals: .streetName)
                    .submitLabel(.next)
                TextField("City", text: $city)
                    .focused($currentFocus, equals: .city)
                    .submitLabel(.next)
                TextField("State", text: $state)
                    .focused($currentFocus, equals: .state)
                    .submitLabel(.next)
                TextField("Zip code", text: $zipCode)
                    .focused($currentFocus, equals: .zipCode)
                    .submitLabel(.done)
            }
        }
        .onSubmit {
            switch currentFocus {
            case .streetName:
                currentFocus = .city
            case .city:
                currentFocus = .state
            case .state:
                currentFocus = .zipCode
            default:
                print("Thanks for providing your address")
            }
        }
    }
}

#Preview {
    FocusAndSubmit()
}
