//
//  MovieCredits.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/10/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//
// Get the movie credits for a person. Show their cast or crewed movies.

import Foundation

struct MovieCredits: Codable {
    let id: Int
    let cast: [CastMovie]
    let crew: [CrewMovie]
}

struct CastMovie: Codable {
    let id: Int
    let backdropPath: String?
    let posterPath: String?
    let title: String?
    
    static var `default`: CastMovie {
        CastMovie(id: 0, backdropPath: "", posterPath: "", title: "")
    }
}

struct CrewMovie: Codable {
    let id: Int
    let backdropPath: String?
    let posterPath: String?
    let originalTitle: String?
    
    static var `default`: CrewMovie {
        CrewMovie(id: 0, backdropPath: "", posterPath: "", originalTitle: "")
    }
}
