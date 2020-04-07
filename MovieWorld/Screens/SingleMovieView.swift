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

                if model.secSectionMoviesBundle.isEmpty {
                    Text("Loading")
                } else {
                    VStack {
                        CrewList(crews: (model.secSectionMoviesBundle[.Crew] as! [CrewViewModel]).filter {$0.job == "Director"} )
                        CastList(casts: model.secSectionMoviesBundle[.Cast] as! [CastViewModel])
                    }

                }
            }
        }.edgesIgnoringSafeArea(.top)
        .onAppear() {
                self.model.getMovieDetail(id: self.movieId)
                self.model.getSecSectionMoviesBundle(id: self.movieId)
            }
    }

    struct CrewList: View {
        var crews: [CrewViewModel]

        var body: some View {

            VStack(alignment: .leading) {
                Text("Director")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 6) {
                        ForEach(crews, id: \.self) { crew in
                            VStack(alignment: .leading) {
                                KFImage(source: .network(crew.profileUrl))
                                    .resizable()
                                    .frame(maxWidth: 100, maxHeight: 150)
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .cornerRadius(5)
                                Text("\(crew.name)")
                                .lineLimit(nil)
                                    .foregroundColor(.gray)

                            }.frame(width: 100)
                        }
                    }
                }
            }
            .padding(.horizontal).padding(.bottom)
        }
    }

    struct CastList: View {
        var casts: [CastViewModel]

        var body: some View {

            VStack(alignment: .leading) {
                Text("Cast")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 6) {
                        ForEach(casts, id: \.self) { cast in
                            VStack(alignment: .leading) {
                                KFImage(source: .network(cast.profileUrl))
                                    .resizable()
                                    .frame(width: 100, height: 150)
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .cornerRadius(5)
                                Text("\(cast.name)")
                                .lineLimit(2)
                                .foregroundColor(.gray)
                                    .frame(height: 50, alignment: .top)

                            }.frame(width: 100)
                        }
                    }
                }
            }
            .padding(.horizontal).padding(.bottom)
        }
    }

    fileprivate func createPosterImage() -> some View {
        return KFImage(source: .network(model.movie.posterUrl))
            .resizable().aspectRatio(contentMode: .fit)
    }

    fileprivate func createSecCollectionView() -> some View {
        return SecMovieCollectionView(allItems: model.secSectionMoviesBundle)
    }
}


