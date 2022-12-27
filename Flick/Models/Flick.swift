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
    
    static var sample: [Flick] {
        let flick1 = Flick(id: "tt3896198",
                           title: "Guardians of the Galaxy Vol. 2",
                           plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
                           poster: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
                           rating: "7.0")
        let flick2 = Flick(id: "tt0848228",
                           title: "The Avengers",
                           plot: "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.",
                           poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
                           rating: "8.0")
        let flick3 = Flick(id: "tt0974015",
                           title: "Justice League",
                           plot: "Fueled by his restored faith in humanity and inspired by Superman's selfless act, Bruce Wayne enlists the help of his new-found ally, Diana Prince, to face an even greater enemy.",
                           poster: "https://m.media-amazon.com/images/M/MV5BYWVhZjZkYTItOGIwYS00NmRkLWJlYjctMWM0ZjFmMDU4ZjEzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
                           rating: "6.1")
        return [flick1, flick2, flick3]
    }
}
