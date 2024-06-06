//
//  PinchToZoom.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 06.06.24.
//

import SwiftUI

struct PinchToZoom: View {
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    var body: some View {
        VStack {
            Circle()
                .fill(.blue)
                .frame(width: 200, height: 200)
                .scaleEffect(currentZoom + totalZoom)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentZoom = value - 1
                        }
                        .onEnded { value in
                            totalZoom += currentZoom
                            currentZoom = 0
                        }
                )
            
//            Text("Hello, World!")
//                .font(.title)
//                .scaleEffect(currentZoom + totalZoom)
//                .gesture(
//                    MagnificationGesture()
//                        .onChanged { value in
//                            currentZoom = value - 1
//                        }
//                        .onEnded { value in
//                            totalZoom += currentZoom
//                            currentZoom = 0
//                        }
//                )
        }
    }
}

#Preview {
    PinchToZoom()
}
