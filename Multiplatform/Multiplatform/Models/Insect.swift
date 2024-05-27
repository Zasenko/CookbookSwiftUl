//
//  Insect.swift
//  Multiplatform
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import Foundation

struct Insect: Decodable, Identifiable, Hashable {
    var id: Int
    var imageName: String
    var name: String
    var habitat: String
    var description: String
}

extension Insect {
    static var oneInsect = Insect(
        id: 1,
        imageName: "grasshopper",
        name: "grass",
        habitat: "pond",
        description: "long description here"
    )
    
    static var manyInsects: [Insect] = {
        guard let url = Bundle.main.url(
            forResource: "insectDataJson",
            withExtension: "json"
        ),
              let data = try? Data(contentsOf: url)
        else {
            return []
        }
        let decoder  = JSONDecoder()
        let array = try?decoder.decode([Insect].self, from: data)
        return array ??  [oneInsect]
    }()
}
