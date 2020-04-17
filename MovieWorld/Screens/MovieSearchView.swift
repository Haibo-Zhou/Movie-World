//
//  MovieSearchView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/17/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct MovieSearchView: View {
    @ObservedObject var model = MovieListViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onTextChanged: searchMovies)
                List {
                    ForEach(model.searchResults.filter {
                        self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                    }) { movie in
                        Text(movie.title)
                    }
                }
            }
        }
    }
    
    func searchMovies(for searchText: String) {
        if !searchText.isEmpty {
            model.getMovieSearchResults(for: self.searchText)
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
