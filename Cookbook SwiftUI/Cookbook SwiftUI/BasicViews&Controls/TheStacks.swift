//
//  TheStacks.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 23.05.24.
//

import SwiftUI

struct TheStacks: View {
    var body: some View {
        VStack {
            Text("VStack Item 1")
            Text("VStack Item 2")
            Spacer()
            Divider()
                .background(.black)
            Text("VStack Item 3")
            
            
            HStack{
               Text("HStack Item 1")
               Divider()
                   .background(.black)
               Text("HStack Item 2")
               Divider()
                    .background(.black)
               Spacer()
               Text("HStack Item 3")
            }
            .background(Color.red)
            ZStack{
                Text("ZStack Item 1")
                     .padding()
                     .background(.green)
                     .opacity(0.8)
                 Text("ZStack Item 2")
                     .padding()
                     .background(.green)
                     .offset(x: 80, y: -400)
              }
        }
        .background(.blue)
    }
}

#Preview {
    TheStacks()
}
