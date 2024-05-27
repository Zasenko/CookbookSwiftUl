//
//  DelayedButtonsAnimations.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct DelayedButtonsAnimations: View {
    
    @State var hideFirst = true
    @State var hideSecond = true
    @State var hideThird = true
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 30) {
                Text("First")
                    .styled(color: .red)
                    .opacity(hideFirst ? 0 : 1)
                Text("Second")
                    .styled(color: .blue)
                    .opacity(hideSecond ? 0 : 1)
                Text("Third")
                    .styled(color: .yellow)
                    .opacity(hideThird ? 0 : 1)
            }
            Spacer()
            Button  {
                // 1st option:
//                withAnimation(Animation.easeInOut) {
//                    hideFirst.toggle()
//                }
//                withAnimation(Animation.easeInOut.delay(0.3)) {
//                    hideSecond.toggle()
//                }
//                withAnimation(Animation.easeInOut.delay(0.6)) {
//                    hideThird.toggle()
//                }
                
                withAnimation(Animation.easeInOut) {
                        hideFirst.toggle()
                    } completion: {
                        withAnimation(Animation.easeInOut) {
                            hideSecond.toggle()
                        } completion: {
                            withAnimation(Animation.easeInOut) {
                                hideThird.toggle()
                            }
                } }
            } label: {
                Text("Animate")
                    .fontWeight(.heavy)
                    .styled(color: .green)
            }
        }
    }
}

#Preview {
    DelayedButtonsAnimations()
}

struct CustomText: ViewModifier {
    let foreground: Color
    let background: Color
    let cornerRadius: Double
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(foreground)
            .frame(width: 200)
            .padding()
            .background(background)
            .cornerRadius(cornerRadius)
    }
}

extension Text {
    func styled(color: Color) -> some View {
        modifier(CustomText(foreground: .white,
                            background: color,
                            cornerRadius: 10))
    }
}
