//
//  ScrollViewReaders.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 24.05.24.
//

import SwiftUI

struct ScrollViewReaders: View {
    
    @State private var scrolledID: CharacterInfo.ID?
    
    var body: some View {
        HStack(spacing: 20) {
            iOS17
            iOS14
        }
    }
    
    var iOS17: some View {
        VStack {
            Text("iOS 17+")
                .foregroundStyle(.blue)
                .font(.title)
            ScrollView {
                Button("Go to letter Q") {
                    scrolledID = 16
                }
                .padding()
                .background(.blue)
                .tint(.yellow)
                ForEach(CharacterInfo.charArray) { image in
                    Image(systemName: image.name)
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                        .frame(width: 90, height: 90)
                        .background(.yellow)
                        .padding()
                }
                Button("Go to letter G") {
                    withAnimation {
                        scrolledID = 6
                    }
                }
                .padding()
                .background(.blue)
                .tint(.yellow)
            }
            .scrollPosition(id: $scrolledID)
        }
    }
    
    var iOS14: some View {
        VStack {
            Text("iOS 14+")
                .foregroundStyle(.blue)
                .font(.title)
            ScrollView {
                ScrollViewReader { proxy in
                    Button("Go to letter Q") {
                        proxy.scrollTo(16)
                    }
                    .padding()
                    .background(.yellow)
                    ForEach(CharacterInfo.charArray) { image in
                        Image(systemName: image.name)
                            .font(.largeTitle)
                            .foregroundStyle(.yellow)
                            .frame(width: 90, height: 90)
                            .background(.blue)
                            .padding()
                    }
                    Button("Go to letter G") {
                        withAnimation {
                            proxy.scrollTo(6, anchor: .top)
                        }
                    }
                    .padding()
                    .background(.yellow)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ScrollViewReaders()
}

struct CharacterInfo: Identifiable {
    var name: String
    var id: Int
}

extension CharacterInfo {
    static let charArray = [
        CharacterInfo (name:"a.circle.fill",id:0),
        CharacterInfo (name:"b.circle.fill",id:1),
        CharacterInfo (name:"c.circle.fill",id:2),
        CharacterInfo (name:"d.circle.fill",id:3),
        CharacterInfo (name:"e.circle.fill",id:4),
        CharacterInfo (name:"f.circle.fill",id:5),
        CharacterInfo (name:"g.circle.fill",id:6),
        CharacterInfo (name:"h.circle.fill",id:7),
        CharacterInfo (name:"i.circle.fill",id:8),
        CharacterInfo (name:"j.circle.fill",id:9),
        CharacterInfo (name:"k.circle.fill",id:10),
        CharacterInfo (name:"l.circle.fill",id:11),
        CharacterInfo (name:"m.circle.fill",id:12),
        CharacterInfo (name:"n.circle.fill",id:13),
        CharacterInfo (name:"o.circle.fill",id:14),
        CharacterInfo (name:"p.circle.fill",id:15),
        CharacterInfo (name:"q.circle.fill",id:16),
    ]
}
