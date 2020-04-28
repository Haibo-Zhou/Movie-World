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
            RatingView(value: movie.voteAverage).padding(.bottom)
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
                VStack(alignment: .leading, spacing: 10) {
                    Text(String(value))
                    .font(.system(size: 35, weight: .black, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    
                    StarRatingView(ratingScore: value, usedInMovieList: false)
                }
                
                Spacer()
                Image("tmdb_logo")
            }
        }
    }
    
    fileprivate func createTitle() -> some View {
        if let currentDeviceLanguage = Bundle.main.preferredLocalizations.first {
            if currentDeviceLanguage == "zh-Hans" {
                if self.movie.titleCn != "" {
                    return Text(self.movie.titleCn)
                    .font(.system(size: 35, weight: .black, design: .rounded))
                    .layoutPriority(1) // let title has the hightest priority to take the space firstly
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                }
            }
        }
        return Text(self.movie.title)
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
        if let currentDeviceLanguage = Bundle.main.preferredLocalizations.first {
            // print("Language: \(currentDeviceLanguage)")
            if currentDeviceLanguage == "zh-Hans" {
                if self.movie.overviewCn != "" { // return en text if cn text is not avaiable
                    return Text(self.movie.overviewCn)
                    .lineLimit(nil)
                    .font(.body)
                }
            }
        }
        return Text(self.movie.overview)
            .lineLimit(nil)
            .font(.body)
    }
}

