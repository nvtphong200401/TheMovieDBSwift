//
//  MovieDetailView.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import SwiftUI
import RemoteImage

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        let poster = viewModel.movie?.posterURL ?? URL(string: "https://img.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-1932.jpg?w=1380&t=st=1682406174~exp=1682406774~hmac=b425dd5987977e6f71891d4add979c8e62e1773b101dd0bc1f6c5cb07a46c4aa")!
        ScrollView {
            VStack {
                RemoteImage(type: .url(poster), errorView: {error in
                    Image(systemName: "film")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }, imageView: {image in
                    image.resizable().aspectRatio(contentMode: .fit)
                }, loadingView: {
                    Text("Loading ...")
                })
                Text(viewModel.movie?.title ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                Text(viewModel.movie?.overview ?? "")
                    .font(.body)
                    .padding(.horizontal)
            }
        }
        .navigationBarTitle(viewModel.movie?.title ?? "", displayMode: .inline)
        .task {
            await viewModel.loadMovie()
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(movieID: 502356))
    }
}
