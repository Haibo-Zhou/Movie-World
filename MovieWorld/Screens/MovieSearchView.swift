//
//  MovieSearchView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/17/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct MovieSearchView: View {
    @ObservedObject var model = MovieListViewModel()
    @State private var searchText: String = ""
    @State private var selectedId = -1
    @State private var showSheet = false
    @State private var page = 1
    
    var body: some View {
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
            }.simultaneousGesture(DragGesture().onChanged({ _ in
                // dismiss keyboard when scrolling begins
                UIApplication.shared.endEditing()
            }))
            .sheet(isPresented: $showSheet) {
                SingleMovieView(movieId: self.selectedId)
            }
            
            // For Firebase mobile Ads
            BannerView()
                .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
        }
        
    }
    
    func searchMovies(for searchText: String) {
        if !searchText.isEmpty {
            self.page = 1
            self.model.getMovieSearchResults(for: self.searchText, page: self.page)
        } else {
            // remove search result when a user clear keyword.
            self.page = 1
            self.model.searchResults.removeAll()
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
