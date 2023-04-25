//
//  MovieCache.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation

protocol MovieCacheProtocol {
    func movies(forCategory category: MovieCategory, page: Int) -> [Movie]?
    func saveMovies(_ movies: [Movie], forCategory category: MovieCategory, page: Int)
    func movie(withID id: Int) -> Movie?
    func saveMovie(_ movie: Movie)
}

class MovieCache: MovieCacheProtocol {
    private var movieList: [MovieCategory: [Int: [Movie]]] = [:]
    
    func movies(forCategory category: MovieCategory, page: Int) -> [Movie]? {
        return movieList[category]?[page]
    }
    
    func saveMovies(_ movies: [Movie], forCategory category: MovieCategory, page: Int) {
        if self.movieList[category] == nil {
            self.movieList[category] = [:]
        }
        self.movieList[category]?[page]?.append(contentsOf: movies)
    }
    
    func movie(withID id: Int) -> Movie? {
        for categoryMovies in movieList.values {
            for pageMovies in categoryMovies.values {
                if let movie = pageMovies.first(where: { $0.id == id }) {
                    return movie
                }
            }
        }
        return nil
    }
    
    func saveMovie(_ movie: Movie) {
        //        if movies[movie.category] == nil {
        //            movies[movie.category] = [:]
        //        }
        //        if movies[movie.category]?[1] == nil {
        //            movies[movie.category]?[1] = []
        //        }
        //        movies[movie.category]?[1]?.append(movie)
    }
    
}
