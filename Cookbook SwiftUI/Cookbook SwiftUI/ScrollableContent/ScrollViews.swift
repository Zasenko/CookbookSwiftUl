//
//  ScrollViews.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 24.05.24.
//

import SwiftUI

struct ScrollViews: View {
    
    let letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]
    @State private var flashIndicators = false
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(letters, id: \.self) {letter in
                    Image(systemName: letter)
                        .font(.largeTitle)
                        .foregroundStyle(.yellow)
                        .frame(width: 50, height: 50)
                        .background(.blue)
                        .symbolVariant(.circle.fill)
                }
            }
            .frame(width:50, height:200)
            .scrollIndicators(.hidden, axes: .vertical)
            
            ScrollView(.horizontal) {
                HStack{
                    ForEach(letters, id: \.self){name in
                        Image(systemName: name)
                            .font(.largeTitle)
                            .foregroundStyle(.yellow)
                            .frame(width: 50, height: 50)
                            .background(.blue)
                            .symbolVariant(.circle.fill)
                    }
                }
            }
            .scrollIndicatorsFlash(trigger: flashIndicators)
            .padding(.bottom)
            Button("Flash ") {
                flashIndicators.toggle()
            }
        }
    }
}

#Preview {
    ScrollViews()
}
