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
        if path == "" {
            print("path is empty")
            // Place holder image
            return URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Blank_portrait%2C_male_(rectangular).png/594px-Blank_portrait%2C_male_(rectangular).png")!
        } else {
            return URL(string: "\(baseUrl)\(size)\(path)")!
        }
        
//        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
//            return url
//        } else {
//            print("NONONO")
//        }
//
//        // Place holder image, will not reach here actually.
//        return URL(string: "https://www.douban.com/photos/photo/2594611618/")!
    }
}
