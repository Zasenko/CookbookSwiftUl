//
//  CustomViewTransition.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct CustomViewTransition: View {
    @State var showFirst = true
    
    var body: some View {
        VStack(spacing: 24) {
            if showFirst {
                FirstView1()
                    .transition(.moveScaleAndFade)
            } else {
                SecondView1()
                .transition(.moveScaleAndFade)
            }
            Button {
                showFirst.toggle()
            } label: {
                Text("Change")
            }
        }
        .animation(Animation.easeInOut, value: showFirst)
        .padding(.horizontal, 20)
        
    }
}

#Preview {
    CustomViewTransition()
}

extension Image {
    func custom() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}
struct FirstView1: View {
    var body: some View {
        Image(.image1)
            .custom()
    }
}
struct SecondView1: View {
    var body: some View {
        Image(.image2)
            .custom()
    }
}
extension AnyTransition {
    static var moveScaleAndFade: AnyTransition {
        let insertion = AnyTransition
            .scale
            .combined(with: .move(edge: .leading))
            .combined(with: .opacity)
        let removal = AnyTransition
            .scale
            .combined(with: .move(edge: .top))
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion,
                             removal: removal)
} }
