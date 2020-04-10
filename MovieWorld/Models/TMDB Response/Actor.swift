//
//  Actor.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/8/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct TMDBActorsResult: Codable {
    let page: Int?
    let results: [Actor]
    let totalResults: Int?
    let totalPages: Int?
}

struct Actor: Codable {
    let profilePath: String?
    let adult: Bool
    let id: Int?
    let name: String?
    let popularity: CGFloat?
    let knownFor: [Production]?
    // for person Detail
    let biography: String?
    let placeOfBirth: String?
    let imdbId: String?
}

// MARK: Used for two objects with media type = (Movie or TV)
struct Production: Codable {
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let originalTitle: String?
    let genreIds: [Int]?
    let id: Int?
    let mediaType: String?
    let originalLanguage: String?
    let title: String?
    let backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?
    let firstAirDate: String?
    let originCountry: [String]?
    let name: String?
    let originalName: String?
}
