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
        VStack(alignment: .leading) {
            createTitle()
            RatingView(value: movie.voteAverage)
            createGenreList()
            HStack {
                Text(self.movie.releaseDate).foregroundColor(.gray)
                Spacer()
                Text(self.movie.runtime).foregroundColor(.gray)
            }.padding(.vertical)
            createDescription().padding(.vertical)
        }.padding(.horizontal).padding(.bottom, 20)
        
    }
    
    struct RatingView: View {
        var value: Double
        
        var body: some View {
            HStack {
                Image(systemName: "star.circle")
                    .font(.system(.largeTitle))
                    .foregroundColor(.pink)
                Text(String(value))
                    .font(.system(.largeTitle))
                    .foregroundColor(.pink)
            }
        }
    }
    
    fileprivate func createTitle() -> some View {
        return Text(self.movie.titleCn)
            .font(.system(size: 35, weight: .black, design: .rounded))
            .layoutPriority(1) // let title has the hightest priority to take the space firstly
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
    }
    
    fileprivate func createGenreList() -> some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(self.movie.genres, id: \.self) { genre in
                    Text(genre)
                    .bold()
                    .padding(5)
                    .background(Color.lightGray)
                    .cornerRadius(10)
                    .foregroundColor(Color.gray)
                }
            }
        }
    }
    
    fileprivate func createDescription() -> some View {
        return Text(self.movie.overview)
            .lineLimit(nil)
            .font(.body)
    }
}

