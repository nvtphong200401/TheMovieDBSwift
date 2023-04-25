//
//  MovieListRowView.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import SwiftUI

struct MovieListRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            MoviePosterView(posterURL: movie.posterURL)
                .frame(width: 75, height: 100)
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(movie.releaseDate ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(movie.overview)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 4)
        }
    }
}

struct MovieListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListRowView(movie: Movie.example())
    }
}
