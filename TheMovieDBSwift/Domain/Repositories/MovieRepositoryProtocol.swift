//
//  MovieRepository.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieDetail(movieID: Int) -> AnyPublisher<Movie, Error>
}
