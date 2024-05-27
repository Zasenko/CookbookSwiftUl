//
//  InsectCellView.swift
//  Multiplatform
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct InsectCellView: View {
    
    var insect: Insect
    
    var body: some View {
        HStack {
            Image(insect.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Rectangle())
                #if os(macOS)
                .frame(width: 200, height: 160)
                #else
                .frame(width: 100, height: 80)
                #endif
            VStack(alignment: .leading) {
                Text(insect.name)
                    .font(.title)
                Text(insect.habitat)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    InsectCellView(insect: .oneInsect)
}
