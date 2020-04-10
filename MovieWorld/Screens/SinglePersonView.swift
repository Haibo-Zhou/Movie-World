//
//  SingleActorView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/9/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SinglePersonView: View {
    
    var personId: Int = -1
    @ObservedObject var model = MovieListViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                PosterImage(person: model.person)
                PersonDetailView(person: model.person)
                
                if model.personInfoBundle.isEmpty {
                    Text("Loading")
                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        AttendedMovieList(movies: model.personInfoBundle[.CastedMovies] as! [PersonMovieViewModel], model: self.model)
                        PersonImageList(images: model.personInfoBundle[.Images] as! [PersonImageViewModel], model: self.model)
                        
                    }
                    
                }
                
            }
        }.edgesIgnoringSafeArea(.top)
        .onAppear() {
            self.model.getPersonDetail(id: self.personId)
            self.model.getPersonDetailBundle(id: self.personId)
        }
    }
}

struct PersonDetailView: View {
    var person: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(person.name) // person Name
                .font(.system(size: 35, weight: .black, design: .rounded))
            Text(person.biography) // person bio
                .font(.body)
        }.padding(.horizontal).padding(.bottom)
        
    }
    
}

struct PosterImage: View {
    var person: PersonViewModel
    
    var body: some View {
        KFImage(source: .network(person.profileUrl))
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

struct AttendedMovieList: View {
    var movies: [PersonMovieViewModel]
    var model: MovieListViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Known For")
                .font(.headline)
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(movies) { movie in
                        VStack(alignment: .leading) {
                            KFImage(source: .network(movie.posterURL))
                                .resizable()
                                .frame(width: 100, height: 150)
                                .aspectRatio(2/3, contentMode: .fill)
                                .onTapGesture {
                                    // navigation to SingleMovieView
                                }
                            Text("\(movie.title)")
                            .lineLimit(2)
                                .foregroundColor(.gray)
                                .frame(height: 50, alignment: .top)
                        }.frame(width: 100)
                    }
                }
            }
        }.padding(.horizontal).padding(.bottom)
    }
}

struct PersonImageList: View {
    var images: [PersonImageViewModel]
    var model: MovieListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Images")
                .font(.headline)
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 6) {
                    ForEach(images, id: \.self) { image in
                        KFImage(source: .network(image.fileURL))
                        .resizable()
                        .frame(width: 100, height: 150)
                        .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }.frame(height: 150)
        }
        .padding(.horizontal).padding(.bottom)
    }
    
}

struct SinglePersonView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePersonView()
    }
}
