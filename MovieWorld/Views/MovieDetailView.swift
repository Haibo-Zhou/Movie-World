//
//  MovieDetailView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/16/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    var movie: MovieViewModel
    
    var body: some View {
        return VStack {
            createTitle()
            // LineRatingView(value: movie.voteAverage)
            createGenreList()
            HStack {
                Text(self.movie.releaseDate).foregroundColor(.gray)
                Spacer()
                Text(self.movie.runtime).foregroundColor(.gray)
            }.padding(.vertical)
            createDescription()
            // Directors, Actors, Pictures
            Image("bombshell_land").frame(width: 50, height: 80, alignment: .leading)
            Image("bombshell_land").frame(width: 50, height: 80, alignment: .leading)
            Image("bombshell_land").frame(width: 50, height: 80, alignment: .leading)
            
        }
        
    }
    
    fileprivate func createTitle() -> some View {
        return Text(self.movie.title)
            .font(.system(size: 35, weight: .black, design: .rounded))
        // .layoutPriority(1)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
    }
    
    fileprivate func createGenreList() -> some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(self.movie.genres, id: \.self) { genre in
                    Text(genre)
    //                .bold()
    //                .padding(5)
    //                .background(Color.lightGray)
    //                .cornerRadius(10)
    //                .foregroundColor(Color.gray)
                }
            }
        }
    }
    
    fileprivate func createDescription() -> some View {
        return Text(self.movie.overview).lineLimit(nil).font(.body)
    }
}

