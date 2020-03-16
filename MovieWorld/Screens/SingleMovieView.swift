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
            VStack(alignment: .leading)  {
                createPosterImage()
                MovieDetailView(movie: self.model.movie)
            }
        }//.edgesIgnoringSafeArea(.top)
            .onAppear() {
                self.model.getMovieDetail(id: self.movieId)
            }
        
    }
    
    fileprivate func createPosterImage() -> some View {
        return KFImage(source: .network(model.movie.posterUrl))
    }
}
