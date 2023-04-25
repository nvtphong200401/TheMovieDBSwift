//
//  MovieDetailViewModel.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation
import Combine

@MainActor class MovieDetailViewModel: ObservableObject {
    private let movieID: Int
    private let movieRepository: MovieRepositoryProtocol?
    
    @Published var movie: Movie?
    @Published var errorMessage: String?
    
    init(movieID: Int, movieRepository: MovieRepositoryProtocol = MovieRepository()) {
        self.movieID = movieID
        self.movieRepository = movieRepository
    }
    
    func loadMovie() async {
        do {
            self.movie = try await movieRepository?.fetchMovie(withID: movieID)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
