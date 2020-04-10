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
    let cast: [PersonMovie]
    let crew: [PersonMovie]
}

struct PersonMovie: Codable {
    let id: Int
    let backdropPath: String?
    let posterPath: String?
    let title: String?
    
    static var `default`: PersonMovie {
        PersonMovie(id: 0, backdropPath: "", posterPath: "", title: "")
    }
}

