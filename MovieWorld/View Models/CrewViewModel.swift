//
//  DirectorViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/19/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI


struct CrewViewModel: Identifiable, MixedMovieBundle, Hashable {
    
    var profileUrl: URL
    var creditId: String
    var department: String
    var gender: Int
    var id: Int
    var job: String
    var name: String
    

    private let baseImageUrl = "https://image.tmdb.org/t/p/"
    private let backdropSize = "w780"
    private let posterSize = "w342"
    

    static var `default` : CrewViewModel {
        get {
            CrewViewModel(crew: Crew(creditId: "", department: "", gender: 0, id: 0, job: "", name: "", profilePath: ""))
        }
    }

    init(crew: Crew) {
        self.profileUrl = CrewViewModel.posterImageUrl(with: crew.profilePath ?? "", baseUrl: self.baseImageUrl, size: posterSize)
        self.creditId = crew.creditId ?? "N/A"
        self.department = crew.department ?? "N/A"
        self.gender = crew.gender ?? 0
        self.id = crew.id ?? 0
        self.job = crew.job ?? "N/A"
        self.name = crew.name ?? "N/A"
    }


    static private func posterImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
            return url
        }

        return URL(string: "https://via.placeholder.com/150/0000FF/808080?Text=No&image&available")!
    }

}
