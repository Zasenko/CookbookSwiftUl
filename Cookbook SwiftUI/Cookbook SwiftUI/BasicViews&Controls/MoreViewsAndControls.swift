//
//  MoreViewsAndControls.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 23.05.24.
//

import SwiftUI

struct MoreViewsAndControls: View {
    
    @State private var progress = 0.5
    @State private var color  = Color.red
    @State private var secondColor  = Color.yellow
    @State private var someText = "Initial value"
    
    var body: some View {
        List {
            Section(header: Text("ProgressViews")) {
                ProgressView("Indeterminate progress view")
                ProgressView("Downloading",value: progress, total: 2)
            }
            Button("More") {
                if (progress < 2) {
                    progress += 0.5
                }
            }
            Section(header: Text("Labels")) {
                Label("Slow", systemImage: "tortoise.fill")
                Label {
                    Text ("Fast")
                        .font(.title)
                } icon: {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 40, height: 20, alignment: .center)
                        .overlay(Text("F"))
                }
            }
            Section(header: Text("ColorPicker")) {
                ColorPicker(selection: $color ) {
                    Text("Pick my background")
                        .background(color)
                        .padding()
                }
                ColorPicker("Picker", selection: $secondColor )
            }
            
            Section(header: Text("Link")) {
                Link("Packt Publishing", destination: URL(string: "https://www.packtpub.com/")!)
            }
            
            Section(header: Text("TextEditor")) {
                TextEditor(text: $someText)
                Text("current editor text:\n\(someText)")
            }
            
            Section(header: Text("Menu")) {
                Menu("Actions") {
                    Button("Set TextEditor text to 'magic'"){
                        someText = "magic"
                    }
                    Button("Turn first picker green") {
                        color = Color.green
                    }
                    Menu("Actions") {
                        Button("Set TextEditor text to 'real magic'"){
                            someText = "real magic"
                        }
                        Button("Turn first picker gray") {
                            color = Color.gray
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    MoreViewsAndControls()
}
