//
//  ViewModifiers.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 23.05.24.
//

import SwiftUI

struct ViewModifiers: View {
    var body: some View {
        Text("Perfect")
            .modifier(BackgroundStyle(bgColor: .blue))
        
        Text("Perfect")
            .backgroundStyle(color: Color.red)
    }
}

#Preview {
    ViewModifiers()
}

struct BackgroundStyle: ViewModifier {
    
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width:UIScreen.main.bounds.width * 0.3)
            .foregroundStyle(.black)
            .padding()
            .background(bgColor)
            .cornerRadius(20)
    }
}

extension View {
    func backgroundStyle(color: Color) -> some View{
        self.modifier(BackgroundStyle(bgColor: color))
    }
}
