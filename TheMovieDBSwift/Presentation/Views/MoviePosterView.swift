//
//  MoviePosterView.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import SwiftUI

struct MoviePosterView: View {
    let posterURL: URL?
    

    var body: some View {
        AsyncImage(url: posterURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(8)
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .cornerRadius(8)
            Image(systemName: "film")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
        }.frame(width: 75, height: 100)
        
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterView(posterURL: Movie.example().posterURL)
    }
}
