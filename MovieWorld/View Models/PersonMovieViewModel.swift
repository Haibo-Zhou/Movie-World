//
//  MovieCreditsViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/10/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct PersonMovieViewModel: Identifiable, DummyBundle, Hashable {
    var id: Int
    var posterURL: URL
    var title: String
    
    private let baseImageUrl = "https://image.tmdb.org/t/p/"
//    private let backdropSize = "w780"
    private let posterSize = "w342"
    
    static var `default`: PersonMovieViewModel {
        PersonMovieViewModel(personMovie: PersonMovie(id: 0, backdropPath: "", posterPath: "", title: ""))
    }
    
    init(personMovie: PersonMovie) {
        self.id = personMovie.id
        self.posterURL = PersonMovieViewModel.posterImageUrl(with: personMovie.posterPath ?? "", baseUrl: baseImageUrl, size: posterSize)
        self.title = personMovie.title ?? "N/A"
    }
    
    static private func posterImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
            return url
        }
        
        return URL(string: "https://via.placeholder.com/150/0000FF/808080?Text=No&image&available")!
    }
}


//struct CastMovie: Codable {
//    let id: Int
//    let backdropPath: String?
//    let posterPath: String?
//    let title: String?
//
//    static var `default`: CastMovie {
//        CastMovie(id: 0, backdropPath: "", posterPath: "", title: "")
//    }
//}
