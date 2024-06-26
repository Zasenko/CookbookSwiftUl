//
//  HeroViewTransition.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct HeroViewTransition: View {
    
    @State private var selectedItem: Item!
    @State private var showDetail = false
    @Namespace var animation
    
    var body: some View {
        ZStack {
            DestinationListView(selectedItem: $selectedItem,
                                showDetail: $showDetail,
                                animation: animation)
            if showDetail {
                DestinationDetailView(selectedItem: selectedItem,
                                      showDetail: $showDetail,
                                      animation: animation)
            }
        }
    }
}

#Preview {
    HeroViewTransition()
}

struct Item: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let details: String
}

struct DestinationListView: View {
    @Binding var selectedItem: Item!
    @Binding var showDetail: Bool
    let animation: Namespace.ID
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                ForEach(Item.data) { item in
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .matchedGeometryEffect(id: item.image,
                                               in: animation,
                                               isSource: !showDetail)
                        .onTapGesture {
                            selectedItem = item
                            withAnimation {
                                showDetail.toggle()
                            }
                        }
                }
            }
            .padding(.all, 20)
        }
    }
}


struct DestinationDetailView: View {
    var selectedItem: Item
    @Binding var showDetail: Bool
    let animation: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack {
                Image(selectedItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: selectedItem.image, 
                                           in: animation,
                                           isSource: showDetail)
                Text(selectedItem.title)
                    .font(.title)
                Text(selectedItem.details)
                    .font(.callout)
                    .padding(.horizontal)
                Spacer()
            }
            .ignoresSafeArea(.all)
            Button {
                withAnimation {
                    showDetail.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.8))
                    .clipShape(Circle())
            }
            .padding(.trailing,10)
        }
        .background(Color.white.ignoresSafeArea(.all))
    }
}
