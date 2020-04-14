//
//  MovieListRow.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/13/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MovieListRow: View {
    var movie: MovieViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            MovieImage(movie: movie)
            VStack(alignment: .leading, spacing: 6) {
                MovieTitle(movie: movie)
                Text("Stars Stars Stars")
                MovieCategory(movie: movie)
                
            }
        }.padding(.vertical)
    }
    
    // MARK: Sub-Component
    struct MovieImage: View {
        var movie: MovieViewModel
        
        var body: some View {
            KFImage(source: .network(movie.posterUrl))
            .resizable()
            .aspectRatio(2/3, contentMode: .fit)
            .cornerRadius(8)
                .frame(width: 100)
        }
    }
    
    struct MovieTitle: View {
        var movie: MovieViewModel
        
        var body: some View {
           
            Text(movie.title)
                .font(.headline)
            + Text(" (" + movie.releaseDate.prefix(4) + ")")
                .font(.headline)
                .foregroundColor(.gray)
            
        }
    }
    
    struct MovieCategory: View {
        var movie: MovieViewModel
        
        var body: some View {
            
            Text(movie.genreNames)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.gray)
        }
    }
}
