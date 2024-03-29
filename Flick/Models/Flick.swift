//
//  Flick.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 22.12.2022.
//

import Foundation

struct Flick: Identifiable, Codable, Hashable {
    var id: String
    var title: String
    var plot: String
    var poster: String
    var rating: String
    
    enum CodingKeys: String, CodingKey {
        case rating = "imdbRating"
        case id = "imdbID"
        case title = "Title"
        case plot = "Plot"
        case poster = "Poster"
    }
    
    static var sample: Flick {
        Flick(id: "tt3896198",
              title: "Guardians of the Galaxy Vol. 2",
              plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
              poster: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
              rating: "7.0")
    }
}

extension Flick {
    init(entity: FlickEntity) {
        self.id = entity.id ?? ""
        self.title = entity.title ?? ""
        self.plot = entity.plot ?? ""
        self.poster = entity.poster ?? ""
        self.rating = entity.rating ?? ""
    }
}
