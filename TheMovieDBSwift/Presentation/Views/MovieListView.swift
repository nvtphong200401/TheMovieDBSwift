//
//  MovieListView.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel: MovieListViewModel
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movieID: movie.id))) {
                            MovieListRowView(movie: movie)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Popular Movies"))
            .task {
                    await viewModel.fetchMovies()

            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListViewModel())
    }
}
