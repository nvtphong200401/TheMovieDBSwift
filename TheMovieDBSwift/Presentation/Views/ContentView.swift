//
//  ContentView.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                    MovieListView(viewModel: MovieListViewModel())
                        .tabItem {
                            Image(systemName: "film.fill")
                            Text("Movies")
                        }
                    Text("TV Shows")
                        .tabItem {
                            Image(systemName: "tv.fill")
                            Text("TV Shows")
                        }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
