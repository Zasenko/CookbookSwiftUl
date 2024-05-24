//
//  ViewBuilders.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 23.05.24.
//

import SwiftUI

struct ViewBuilders: View {
    var body: some View {
        VStack {
            BlueCircle {
                Text("some text here")
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 40, height: 40)
            }
            BlueCircle {
                Text("Another example")
            }
        }
    }
}

#Preview {
    ViewBuilders()
}

struct BlueCircle<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
            Spacer()
            Circle()
                .fill(Color.blue)
                .frame(width:20, height:30)
            
        }
        .padding()
    }
}
