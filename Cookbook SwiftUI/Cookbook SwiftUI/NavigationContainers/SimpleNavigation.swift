//
//  SimpleNavigation.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 26.05.24.
//

import SwiftUI

struct SimpleNavigation: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Show First View") {
                    FirstView()
                }
                NavigationLink("Show Second View") {
                    SecondView()
                }
                NavigationLink("Show Thrid View") {
                    ThirdView()
                }
                NavigationLink("Show Fourth View") {
                    FourthView()
                }
                
            }
            .navigationTitle("Top Level")
        }
        .tint(.teal)
    }
}

#Preview {
    NavigationStack {
        SimpleNavigation()
    }
}

struct ChildAView: View {
    
    @State private var title = "Child A"
    
    var body: some View {
        VStack {
            Image(systemName: "a.square")
                .font(.system(size: 80))
                .foregroundStyle(.yellow)
            Text("This is the Child A View")
                .foregroundStyle(.primary)
                .padding()
        }
        .navigationTitle($title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChildBView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "b.square")
                .font(.system(size: 80))
                .foregroundStyle(.brown)
            Text("This is the Child B View")
                .foregroundStyle(.primary)
                .padding()
        }
        .navigationTitle("Child B")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SheetView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: UIColor(red: 0, green: 0.9, blue: 1, alpha: 1))
                    .ignoresSafeArea()
                Text("Sheet with navigation bar")
            }
            .navigationTitle("Sheet title")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.teal, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct FirstView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "circle")
                .font(.system(size: 80))
                .foregroundStyle(.cyan)
            Text("This is the First View")
                .foregroundStyle(.primary)
                .padding()
            VStack(spacing: 20) {
                NavigationLink("Show Child A") {
                    ChildAView()
                }
                NavigationLink("Show Child B") {
                    ChildBView()
                }
            }
        }
        .padding()
        .navigationTitle("First")
    }
}

struct SecondView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "square")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
            Text("This is the Second View")
                .foregroundStyle(.primary)
                .padding()
            List {
                NavigationLink("Show Child A") {
                    ChildAView()
                }
                NavigationLink("Show Child B") {
                    ChildBView()
                }
            }
            .listStyle(.inset)
            .frame(height: 160)
        }
        .padding()
        .navigationTitle("Second")
    }
}

struct ThirdView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            Image(systemName: "triangle")
                .font(.system(size: 80))
                .foregroundStyle(.teal)
                .padding(.vertical, 50)
            Text("This is the Third View")
                .foregroundStyle(.primary)
                .padding()
        }
        .padding()
        .navigationTitle("Third")
        .toolbarBackground(.quaternary, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .toolbar {
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

struct FourthView: View {
    
    @State private var isSheetPresented = false
    
    var body: some View {
        ScrollView {
            Image(systemName: "capsule")
                .font(.system(size: 80))
                .foregroundStyle(.red)
                .padding(.vertical, 50)
            Text("This is the Fourth View")
                .foregroundStyle(.primary)
                .padding()
            Button("Show sheet") {
                isSheetPresented = true
            }
            .sheet(isPresented: $isSheetPresented) {
                SheetView()
                    .presentationDetents([.fraction(0.75)])
                    .presentationDragIndicator(.visible)
            }
        }
        .navigationTitle("Fourth")
        .toolbarBackground(.quaternary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
} }
