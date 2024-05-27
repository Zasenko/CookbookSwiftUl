//
//  DelayedAnimations.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct DelayedAnimations: View {
    
    let duration = 1.0
        @State var change = false
    
    var body: some View {
        VStack(spacing: 30) {
            Rectangle()
                .fill(.blue)
                .offset(y: change ? -300 : 0)
                .animation(.easeInOut(duration: duration).delay(0), value: change)
                .scaleEffect(change ? 0.5 : 1)
                .animation(
                    .easeInOut(duration: duration).delay(duration),
                    value: change
                )
                .rotation3DEffect(
                    change ? .degrees(45) : .degrees(0),
                    axis: (x: 1, y: 0, z: 0)
                )
                .animation(
                    .easeInOut(duration: duration).delay(2*duration),
                    value: change
                )
                .frame(width: 200, height: 200)
            
            Button {
                       change.toggle()
                   } label: {
                       Text("Animate")
                           .fontWeight(.heavy)
                           .foregroundStyle(.white)
                           .padding()
                           .background(.green)
                           .cornerRadius(5)
           }
        }
    }
}

#Preview {
    DelayedAnimations()
}
