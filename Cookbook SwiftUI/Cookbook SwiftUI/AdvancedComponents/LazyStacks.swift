//
//  LazyStacks.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 24.05.24.
//

import SwiftUI

struct LazyStacks: View {
    var body: some View {
        
//        List {
//            ForEach(1...10000, id:\.self) { item in
//                ListRow(id: item, type: "Vertical")
//            }
//        }
        
        VStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(1...10000, id:\.self) { item in
                        ListRow(id: item, type: "Horizontal")
                    }
                }
            }
            .frame(height: 100, alignment: .center)
            
            ScrollView {
                LazyVStack {
                    ForEach(1...10000, id:\.self) { item in
                        ListRow(id: item, type: "Vertical")
                    }
                }
            }
        }
    }
}

#Preview {
    LazyStacks()
}

struct ListRow: View {
    
    let id: Int
    let type: String
    
    init(id: Int, type: String) {
        print("Loading \(type) item \(id)")
        self.id = id
        self.type = type
    }
    
    var body: some View {
        Text("\(type) \(id)").padding()
    }
}
