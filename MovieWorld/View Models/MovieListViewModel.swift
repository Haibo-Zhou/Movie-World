//
//  MovieListViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/10/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import Combine


class MovieListViewModel: ObservableObject {
    private var webService = WebService()
    private var cancellableSet: Set<AnyCancellable> = []
    //private var secCancellableSet: Set<AnyCancellable> = []
    
    @Published var sectionMoviesBundle = [HomeSection: [MovieBundle]]()
    @Published var movie = MovieViewModel.default
    @Published var movieDetailBundle = [MovieDetailSection: [MixedMovieBundle]]()
    @Published var person = PersonViewModel.default
    
    
    func getSectionMoviesBundle() {
        webService.getSectionsPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    print("ERROR: \(error)")
                    break
                }
            }) { (nowPlaying, popular, upComing, topActor) in
                self.sectionMoviesBundle[.NowPlaying] = nowPlaying.results.map(MovieViewModel.init)
                self.sectionMoviesBundle[.Popular] = popular.results.map(MovieViewModel.init)
                self.sectionMoviesBundle[.Upcoming] = upComing.results.map(MovieViewModel.init)
                self.sectionMoviesBundle[.TopActor] = topActor.results.map(PersonViewModel.init)
        }.store(in: &self.cancellableSet)
    }
    
    func getMovieDetailBundle(id: Int) {
        webService.getMovieInfomPublisher(for: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    print("Error AP: \(error)")
                    break
                }
            }) { (movieCredits, movieImages, recMovies) in
                self.movieDetailBundle[.Crew] = movieCredits.crew.map(CrewViewModel.init)
                self.movieDetailBundle[.Cast] = movieCredits.cast.map(CastViewModel.init)
                self.movieDetailBundle[.Images] = movieImages.backdrops.map(ImageViewModel.init)
                self.movieDetailBundle[.Recomm] = recMovies.results.map(MovieViewModel.init)
        }.store(in: &self.cancellableSet)
    }
    
    func getMovieDetail(id: Int) {
        webService.getMovieDetailPublisher(for: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }) { movie in
                self.movie = MovieViewModel(movie: movie)
        }.store(in: &self.cancellableSet)
    }
    
    func getPersonDetail(id: Int) {
        webService.getPersonDetailPublisher(for: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }) { person in
                self.person = PersonViewModel(actor: person)
        }.store(in: &self.cancellableSet)
    }
}
