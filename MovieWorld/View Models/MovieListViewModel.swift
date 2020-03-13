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
    
    @Published var sectionMoviesBundle = [HomeSection: [MovieBundle]]()
    
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
                self.sectionMoviesBundle[.TopActor] = topActor.results.map(ActorViewModel.init)
        }.store(in: &self.cancellableSet)
    }
}
