//
//  MovieListViewModel.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation
import Combine

@MainActor class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol = MovieRepository()) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovies() async {
        isLoading = true
        do {
            self.movies = try await movieRepository.fetchMovies(forCategory: MovieCategory.popular, page: 1)

        } catch {

            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
