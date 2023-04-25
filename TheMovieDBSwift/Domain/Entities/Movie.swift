//
//  Movie.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return URL(string: "https://img.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-1932.jpg?w=1380&t=st=1682406174~exp=1682406774~hmac=b425dd5987977e6f71891d4add979c8e62e1773b101dd0bc1f6c5cb07a46c4aa")
        }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    static func example() -> Movie {
        return Movie(id: 1, title: "Movie", overview: "Example", posterPath: "/liLN69YgoovHVgmlHJ876PKi5Yi.jpg", releaseDate: "2023-04-21", voteAverage: 289)
    }
}
