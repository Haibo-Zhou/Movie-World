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
        case credits(Int) // Get the cast and crew for a movie.
        case movieImages(Int)
        case movieRecommendations(Int)
        case personDetail(Int)
        case movieCredits(Int) // Get the movie credits for a person. Aka person attended movies.
        case personImages(Int) // Get the images for a person.
        case paginatedMovies(HomeSection, Int)
        case paginatedActors(Int)
        case searchMovies(String, Int)
        
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
                return TMDBClient.Endpoints.baseUrl + "/movie/\(movieId)" + Endpoints.apiKeyParam + "&language=en-US&page=1"
                
            case .credits(let movieId):
                return TMDBClient.Endpoints.baseUrl + "/movie/\(movieId)/credits" + Endpoints.apiKeyParam
                
            case .movieImages(let movieId):
                return TMDBClient.Endpoints.baseUrl + "/movie/\(movieId)/images" + Endpoints.apiKeyParam
                
            case .movieRecommendations(let movieId):
                return TMDBClient.Endpoints.baseUrl + "/movie/\(movieId)/recommendations" + Endpoints.apiKeyParam
                
            case .personDetail(let personId):
                return TMDBClient.Endpoints.baseUrl + "/person/\(personId)" + Endpoints.apiKeyParam
                
            case .movieCredits(let personId):
                return TMDBClient.Endpoints.baseUrl + "/person/\(personId)/movie_credits" + Endpoints.apiKeyParam
                
            case .personImages(let personId):
                return TMDBClient.Endpoints.baseUrl + "/person/\(personId)/images" + Endpoints.apiKeyParam
                
            case .paginatedMovies(let section, let page):
                return TMDBClient.Endpoints.baseUrl + "/movie/\(section.rawValue.replacingOccurrences(of: " ", with: "_").lowercased())"
                + Endpoints.apiKeyParam + "&language=en-US&page=\(page)"
                
            case .paginatedActors(let page):
                return TMDBClient.Endpoints.baseUrl + "/person/popular" + Endpoints.apiKeyParam + "&language=en-US&page=\(page)"
                
            case .searchMovies(let query, let page):
                return TMDBClient.Endpoints.baseUrl + "/search/movie" + Endpoints.apiKeyParam + "&language=en-US&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&page=\(page)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
}
