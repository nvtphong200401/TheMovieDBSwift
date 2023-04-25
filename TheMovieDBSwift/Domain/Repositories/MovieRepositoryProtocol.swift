//
//  MovieRepository.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func fetchMovies(forCategory category: MovieCategory, page: Int) async throws -> [Movie]
    func fetchMovie(withID id: Int) async throws -> Movie
}


class MovieRepository: MovieRepositoryProtocol {
    private let networkClient: NetworkClientProtocol
    private let cache: MovieCacheProtocol
    
    init(networkClient: NetworkClientProtocol = NetworkClient(), cache: MovieCacheProtocol = MovieCache()) {
        self.networkClient = networkClient
        self.cache = cache
    }
    
    func fetchMovies(forCategory category: MovieCategory, page: Int) async throws -> [Movie] {
        if let cachedMovies = cache.movies(forCategory: category, page: page) {
            return try Just(cachedMovies)
                .setFailureType(to: Error.self)
                .result.get()
        } else {
            let res: MovieListResponse = try await networkClient.send(param: ListMovieParam(category: category, page: page))
            return res.results
        }
    }
    
    func fetchMovie(withID id: Int) async throws -> Movie {
        if let cachedMovie = cache.movie(withID: id) {
            return try Just(cachedMovie)
                .setFailureType(to: Error.self)
                .result.get()
        } else {
            let res: Movie = try await networkClient.send(param: MovieParam(id: id))
            self.cache.saveMovie(res)
            return res
        }
    }
}
