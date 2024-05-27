//
//  Counter.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct Counter: View {

    @State var refreshedAt: Date = Date()

    
    var body: some View {
        VStack(spacing:12) {
            CounterView()
            Text("Refresh at ") +
            Text(refreshedAt.formatted(date: .omitted, time: .standard) )
            Button {
                refreshedAt = Date()
            } label: {
                Text("Refresh date")
                    .padding()
            }
            .foregroundStyle(.white)
            .background(.blue)
        }
    }
}

#Preview {
    Counter()
}

class CounterVM: ObservableObject {
    @Published var value: Int = 0
    func inc() {
        value += 1
    }
    func dec() {
        value -= 1
    }
}

struct CounterView: View {
    
    @ObservedObject var counter = CounterVM()
        // @StateObject var counter = Counter()
    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(counter.value)")
            HStack(spacing: 12) {
                Button {
                    counter.dec()
                } label: {
                    Text("-")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.red)
                }
                Button {
                    counter.inc()
                } label: {
                    Text("+")
                        .padding()
                }
            }
        }
    }
}
