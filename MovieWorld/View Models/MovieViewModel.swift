//
//  MovieViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/9/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI


enum HomeSection: String, CaseIterable {
    case NowPlaying = "Now Playing"
    case Popular
    case Upcoming
    case TopActor
}

enum MovieDetailSection: String, CaseIterable {
    case Crew
    case Cast
    case Images
    case Recomm = "You Might Also Like"
}

enum PersonInfoSection: String, CaseIterable {
    case DirectedMovies
    case CastedMovies
    case Images
}

struct MovieViewModel: Identifiable, DummyBundle, Hashable {
    
    var id:Int
    var title:String
    var releaseDate:String
    var overview:String
    var popularity:CGFloat
    var genres:[String]
    var voteAverage: Double = 0
    var originalLanguage: String
    var posterUrl:URL
    var backdropUrl:URL
    var runtime: String
    var productionCompany: String
    // for movie list view
    var genreNames: String = ""
    var allGenres: [Int: String]

    private let baseImageUrl = "https://image.tmdb.org/t/p/"
    private let backdropSize = "w1280"
    private let posterSize = "w500"
    
    static  var `default` : MovieViewModel {
        get{
            MovieViewModel(movie: Movie(id: 0, title: "", releaseDate: "", overview: "", popularity: 0, genres: [], voteAverage: 0, originalLanguage: "", posterPath: "", backdropPath: "", voteCount: 0, status: "", runtime: 0, revenue: 0, budget: 0, productionCompanies: [], genreIds: []) )
        }
    }
    
    init(movie: Movie) {
        self.id = movie.id!
        self.title = movie.title ?? "N/A"
        self.releaseDate = movie.releaseDate ?? "No date"
        self.overview = movie.overview ?? "No overview"
        self.popularity = movie.popularity ?? 0
        self.genres = movie.genres?.map({$0.name}) ?? []
        self.originalLanguage = movie.originalLanguage ?? "N/A"
        self.backdropUrl = MovieViewModel.backdropImageUrl(with: movie.backdropPath ?? "", baseUrl: self.baseImageUrl, size: backdropSize)
        self.posterUrl = MovieViewModel.posterImageUrl(with: movie.posterPath ?? "", baseUrl: baseImageUrl, size: posterSize)
        self.runtime = MovieViewModel.formatTime(from: movie.runtime ?? 0)
        self.productionCompany = MovieViewModel.productionCompany(movie: movie)
        
        // for movie list view
        self.allGenres = [28:"Action", 12: "Adventure", 16: "Animation", 35: "Comedy",
        80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family",
        14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music",
        9648: "Mystery", 10749: "Romance", 878: "Science Fiction",
        10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western"]
        
        if let average = movie.voteAverage, average > 0 {
            voteAverage = Double(average)
        }
        
        self.genreNames = getGenreNames(with: movie.genreIds ?? [])
    }
    
    
    private mutating func getGenreNames(with genreIds: [Int]) -> String {
        
        for genreId in genreIds {
            genreNames.append(contentsOf: allGenres[genreId]! + " ")
        }
        return genreNames
    }
    
    
    static private func posterImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
            return url
        }
        
        return URL(string: "https://via.placeholder.com/150/0000FF/808080?Text=No&image&available")!
    }
    
    static private func backdropImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
            return url
        }
        
        return URL(string: "https://via.placeholder.com/150/0000FF/808080?Text=No&image&available")!
    }
       
       
    static private func productionCompany(movie: Movie) -> String {
        
        if let prodCompanies = movie.productionCompanies, !prodCompanies.isEmpty {
            return prodCompanies.first?.name ?? "N/A"
        }
        
        return "N/A"
    }
    
    
    static private func formatTime(from runtime: Int) -> String {
        if runtime == 0 {
            return "00h:00min"
        }

        let hour = runtime / 60
        let min = runtime % 60
        return "\(hour)h : \(min)min"
       }
}
