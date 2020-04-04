//
//  SingleMovieView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/16/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SingleMovieView: View {
    
    var movieId: Int = -1
    
    @ObservedObject var model = MovieListViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack()  {
                createPosterImage()
                MovieDetailView(movie: self.model.movie)
                
                Text("ABC")
            }
            if model.secSectionMoviesBundle.isEmpty {
                Text("Loading...")
            } else {
                createSecCollectionView()
            }
        }.onAppear() {
                self.model.getMovieDetail(id: self.movieId)
                self.model.getSecSectionMoviesBundle(id: self.movieId)
            }
    }
    
    fileprivate func createPosterImage() -> some View {
        return KFImage(source: .network(model.movie.posterUrl))
            .resizable().aspectRatio(contentMode: .fill)
    }
    
    fileprivate func createSecCollectionView() -> some View {
        return SecMovieCollectionView(allItems: model.secSectionMoviesBundle) 
    }
}
