//
//  TMDBClient.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/8/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import Foundation

struct TMDBClient {
    
    static var apiKey = ""
    
    enum Endpoints {
        static private let baseImageUrl = "https://image.tmdb.org/t/p/"
        static private let backdropSize = "w780"
        static private let posterSize = "w342"
        static private let baseUrl = "https://api.themoviedb.org/3"
        static private let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case nowPlayingMovies
        case popularMovies
        case upcomingMovies
        case popularActors
        case movieDetail(Int)
        
        var stringValue: String {
            switch self {
            case .nowPlayingMovies:
                return TMDBClient.Endpoints.baseUrl + "/movie/now_playing" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            case .popularMovies:
                return TMDBClient.Endpoints.baseUrl + "/movie/popular" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            case .upcomingMovies:
                return TMDBClient.Endpoints.baseUrl + "/movie/upcoming" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            case .popularActors:
                return TMDBClient.Endpoints.baseUrl + "/person/popular" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            case .movieDetail(let movieId):
                return TMDBClient.Endpoints.baseUrl + "\(movieId)" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
}
