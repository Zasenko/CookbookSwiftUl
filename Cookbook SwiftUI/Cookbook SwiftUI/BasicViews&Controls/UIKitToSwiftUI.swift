//
//  UIKitToSwiftUI.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 23.05.24.
//

import SwiftUI

struct UIKitToSwiftUI: View {
    
    @State private var animate = true
    
    var body: some View {
        VStack {
            ActivityIndicator(animating:  animate)
            HStack{
                Toggle(isOn: $animate) {
                    Text("Toggle Activity")
                }
            }
            .padding()
        }
    }
}

#Preview {
    UIKitToSwiftUI()
}

struct ActivityIndicator: UIViewRepresentable {
    
    var animating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        if animating {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
