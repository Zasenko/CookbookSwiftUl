//
//  StretchableHeader.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct StretchableHeader: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                StretchableHeaderView(image: Image("las-vegas"))
                ForEach(0..<26) { _ in
                    Row()
                    Divider()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    StretchableHeader()
}

struct Row: View {
    var body: some View {
        HStack {
            Image("dublin")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Spacer()
            VStack(alignment: .trailing) {
                Text("Billie Eilish")
                    .fontWeight(.heavy)
                Text("Happier Than Ever")
            }
        }
        .padding(.horizontal, 15)
    }
}

struct StretchableHeaderView: View {
    let image: Image
    var body: some View {
        GeometryReader { geometry in
            image
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width,
                       height: geometry.height)
                .offset(y: geometry.verticalOffset)
        }
        .frame(height: 350)
    }
}

extension GeometryProxy {
    private var offset: CGFloat { frame(in: .global).minY }
    var height: CGFloat { size.height + (offset > 0 ? offset : 0) }
    var verticalOffset: CGFloat { offset > 0 ? -offset : 0 }
}
