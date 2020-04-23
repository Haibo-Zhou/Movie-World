//
//  Movie.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/8/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI


struct TMDBMoviesResult: Codable {
    let page:Int
    let totalPages:Int
    let results:[Movie]
}


struct Genre: Codable {
    let id:Int
    let name:String
}

struct ProductionCompany: Codable {
    let name: String
}

struct Movie: Codable {
 
    let id:Int?
    let title:String?
    let releaseDate:String?
    let overview:String?
    let popularity:CGFloat?
    let genres: [Genre]?
    let voteAverage: CGFloat?
    let originalLanguage: String?
    let posterPath:String?
    let backdropPath:String?
    let voteCount:Int?
    let status:String?
    let runtime,revenue:Int?
    let budget: Int?
    let productionCompanies: [ProductionCompany]?
    let translations: Translation?
    
    // for movie list view
    let genreIds: [Int]?

    
//    static var `default`: Movie {
//        Movie(id: 0, title: "", releaseDate: "", overview: "", popularity: 0, genres: [], voteAverage: 0, originalLanguage: "", posterPath: "", backdropPath: "", voteCount: 0, status: "", runtime: 0, revenue: 0, budget: 0, productionCompanies: [], translations: , genreIds: [])
//    }
    
}

struct Translation: Codable {
    let translations: [TranslationItem]
    
    static var `default`: Translation {
        Translation(translations: [])
    }
}

struct TranslationItem: Codable {
    let iso31661: String
    let name: String?
    let data: TranslationItemData
}

struct TranslationItemData: Codable {
    let overview: String?
    let title: String?
    let biography: String?
}

