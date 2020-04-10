//
//  CastViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/19/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI


struct CastViewModel: Identifiable, DummyBundle, Hashable {

    var profileUrl: URL
    var id: Int
    var name: String
    var castId: Int
    var character: String
    var creditId: String
    var gender: Int
    var order: Int

    private let baseImageUrl = "https://image.tmdb.org/t/p/"
    private let backdropSize = "w780"
    private let posterSize = "w342"
    

    static var `default` : CastViewModel {
        get {
            CastViewModel(cast: Cast(castId: 0, character: "", creditId: "", gender: 0, id: 0, name: "", order: 0, profilePath: "") )
        }
    }

    init(cast: Cast) {
        
        self.profileUrl = CastViewModel.posterImageUrl(with: cast.profilePath ?? "", baseUrl: self.baseImageUrl, size: posterSize)
        self.id = cast.id!
        self.name = cast.name ?? "N/A"
        self.castId = cast.castId ?? 0
        self.character = cast.character ?? "N/A"
        self.creditId = cast.creditId ?? "N/A"
        self.gender = cast.gender ?? 0
        self.order = cast.order ?? 0
    }


    static private func posterImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        
        if path == "" {
            //print("path is empty")
            // Place holder image
            return URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Blank_portrait%2C_male_(rectangular).png/594px-Blank_portrait%2C_male_(rectangular).png")!
        } else {
            return URL(string: "\(baseUrl)\(size)\(path)")!
        }
        
        
//        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
//            return url
//        }
//
//        return URL(string: "https://www.douban.com/photos/photo/2594611618/")!
    }

}
