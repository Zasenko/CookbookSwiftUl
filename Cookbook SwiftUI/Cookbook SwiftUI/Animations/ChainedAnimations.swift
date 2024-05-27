//
//  ChainedAnimations.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct ChainedAnimations: View {
    @State var trigger = false
    
    var body: some View {
        VStack(spacing: 60) {
            HStack(spacing: 60) {
                Image(systemName: "sun.max")
                    .resizable()
                    .foregroundStyle(.yellow)
                    .frame(width: 80, height: 80)
                    .phaseAnimator(Array(-30...30), trigger: trigger) { content, phase in
                        content
                            .rotationEffect(.degrees(24 * Double(phase)))
                            .scaleEffect(1.0 - CGFloat(abs(phase)) / 30.0)
                            .offset(y: CGFloat(-12 * abs(phase)))
                    } animation: { phase in
                        .linear(duration: 0.04 )
                    }
                
                PhaseAnimator([360, 0], trigger: trigger) { phase in
                    ZStack {
                            Image(systemName: "soccerball")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .rotationEffect(.degrees(Double(phase - 360)))
                            Image(systemName: "baseball")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.brown)
                                .offset(x: 0, y: -70)
                                .rotationEffect(.degrees(Double(-phase)))
                        }
                } animation: { phase in
                    if phase == 0 {
                        .none
                    } else {
                        .linear(duration: 4.8)
                    }
                }
            }
            Button  {
                trigger.toggle()
            } label: {
                Text("Animate")
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.green)
                    .cornerRadius(5.0)
            }
        }
    }
}

#Preview {
    ChainedAnimations()
}
