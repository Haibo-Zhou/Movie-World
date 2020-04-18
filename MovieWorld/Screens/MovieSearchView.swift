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
    @State private var selectedId = -1
    @State private var showSheet = false
    @State private var page = 1
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onTextChanged: searchMovies)
                List {
                    ForEach(0..<model.searchResults.count, id: \.self) { i in
                        MovieListRow(movie: self.model.searchResults[i])
                            .onTapGesture {
                                self.selectedId = self.model.searchResults[i].id
                                self.showSheet.toggle()
                            }
                        .onAppear() {
                            if i == self.model.searchResults.count - 1 {
                                self.page += 1
                                self.model.getMovieSearchResults(for: self.searchText, page: self.page)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showSheet) {
                    SingleMovieView(movieId: self.selectedId)
                }
            }
        }
    }
    
    func searchMovies(for searchText: String) {
        if !searchText.isEmpty {
            self.model.getMovieSearchResults(for: self.searchText, page: self.page)
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
