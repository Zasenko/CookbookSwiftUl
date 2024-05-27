//
//  InfiniteScrolling.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct InfiniteScrolling: View {
    
    private let service = PixabayService()
       @State private var pixabayImages: [PixabayImage] = []
       @State private var page = 1
    
    var body: some View {
        List(pixabayImages) { pixabayImage in
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: pixabayImage.webformatURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10.0, height: 10.0)))
                } placeholder: {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .foregroundStyle(.quaternary)
                        .aspectRatio(contentMode: .fit)
                }
                HStack {
                    ForEach(pixabayImage.tagsList, id:\.self) { tag in
                        Text(tag)
                            .font(.caption2)
                            .padding(7.0)
                            .foregroundStyle(.black)
                            .background(.yellow)
                            .clipShape(Capsule())
                    }
                    Spacer()
                    Text("by \(pixabayImage.user) via Pixabay")
                        .font(.caption2)
                        .italic()
                }
            }
            .task {
                if pixabayImage == pixabayImages.last {
                    page += 1
                    pixabayImages += await service.fetchImages(page: page)
                }
            }
        }
        .listStyle(.plain)
        .task {
            pixabayImages = await service.fetchImages(page: page)
        }
    }
}

#Preview {
    InfiniteScrolling()
}

struct PixabayImage: Identifiable, Codable, Equatable {
    
    let id: Int
    let tags: String
    let webformatURL: String
    let user: String
    
    var tagsList: [String] {
        tags.components(separatedBy: ", ")
    }
}

struct PixabayResponse: Codable {
    
    let images: [PixabayImage]
    
    enum CodingKeys: String, CodingKey {
        case images = "hits"
    }
}

struct PixabayService {
    private func searchImagesUrl(page: Int) -> URL? {
        let api = "https://pixabay.com/api/"
        let apiKey = "35788660-40cd4b84edae8823bcb699396"
        let q = "waterfall"
        let query = "?key=\(apiKey)&image_type=photo&orientation=horizontal&q=\(q)&per_page=10&page=\(page)"
        return  URL(string: api + query)
    }
    func fetchImages(page: Int) async -> [PixabayImage] {
        guard let url = searchImagesUrl(page: page) else { return [] }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(PixabayResponse.self, from: data)
            return response.images
        } catch {
            print(error)
            return []
        }
    }
}
