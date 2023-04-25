//
//  MovieResponse.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
