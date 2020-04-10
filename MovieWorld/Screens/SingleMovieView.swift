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

                if model.movieDetailBundle.isEmpty {
                    Text("Loading")
                }
                else {
                    VStack(alignment: .leading, spacing: 12) {
                        CrewList(crews: (model.movieDetailBundle[.Crew] as! [CrewViewModel]).filter {$0.job == "Director"} )
                        CastList(casts: model.movieDetailBundle[.Cast] as! [CastViewModel])
                        ImageList(images: model.movieDetailBundle[.Images] as! [ImageViewModel])
                        RecMovieList(movies: model.movieDetailBundle[.Recomm] as! [MovieViewModel])
                    }
                }
            }
        }.edgesIgnoringSafeArea(.top)
        .onAppear() {
                self.model.getMovieDetail(id: self.movieId)
                self.model.getMovieDetailBundle(id: self.movieId)
        }
    }

    struct CrewList: View {
        //var allItems: [HomeSection:[MovieBundle]]
        //var didSelectItem: ( (_ indexPath: IndexPath) -> () ) = {_ in}
        //var seeAllforSection: ( (_ section: HomeSection)->() ) = {_ in }
        
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
                                .aspectRatio(2/3, contentMode: .fill)
                                .cornerRadius(5)
                                
                                Text("\(crew.name)")
                                .lineLimit(nil)
                                .foregroundColor(.gray)

                            }
                            //.frame(width: 100)
                        }
                    }
                }.frame(height: 180)
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
                                    .aspectRatio(2/3, contentMode: .fill)
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
    
    struct ImageList: View {
        var images: [ImageViewModel]

        var body: some View {

            VStack(alignment: .leading) {
                Text("Images")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 6) {
                        ForEach(images, id: \.self) { image in
                            KFImage(source: .network(image.fileURL))
                                .resizable()
                                .frame(width: 200)
                                .aspectRatio(1.77, contentMode: .fit)
                        }
                    }
                }.frame(height: 120)
            }
            .padding(.horizontal).padding(.bottom)
        }
    }
    
    struct RecMovieList: View {
        
        var movies: [MovieViewModel]
        @ObservedObject var model = MovieListViewModel()

        var body: some View {
            VStack(alignment: .leading) {
                Text("\(MovieDetailSection.Recomm.rawValue)")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 10) {
                        ForEach(0..<movies.count) { i in
                            VStack(alignment: .leading) {
                                    KFImage(source: .network(self.movies[i].posterUrl))
                                    .resizable()
                                    .frame(width: 100, height: 150)
                                    .aspectRatio(2/3, contentMode: .fill)
                                    .onTapGesture {
                                        self.model.getMovieDetail(id: self.movies[i].id)
                                        self.model.getMovieDetailBundle(id: self.movies[i].id)
                                    }
                                
                                Text("\(self.movies[i].title)")
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

//    fileprivate func createSecCollectionView() -> some View {
//        return SecMovieCollectionView(allItems: model.secSectionMoviesBundle)
//    }
}


