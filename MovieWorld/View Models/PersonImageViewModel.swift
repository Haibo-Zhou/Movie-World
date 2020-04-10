//
//  PersonImageViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/10/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI


struct PersonImageViewModel: DummyBundle, Hashable {

    var fileURL: URL
    var aspectRatio: Float
    var height: Int
    var iso6391: String
    var voteAverage: Float
    var voteCount: Int
    var width: Int

    private let baseImageUrl = "https://image.tmdb.org/t/p/"
    private let backdropSize = "w780"
    private let posterSize = "w342"
    

    static var `default` : PersonImageViewModel {
        get {
            PersonImageViewModel(image: Profile(aspectRatio: 0, filePath: "", height: 0, iso6391: "", voteAverage: 0, voteCount: 0, width: 0) )
        }
    }

    init(image: Profile) {
        
        self.fileURL = PersonImageViewModel.posterImageUrl(with: image.filePath ?? "", baseUrl: self.baseImageUrl, size: backdropSize)
        self.aspectRatio = image.aspectRatio ?? 0
        self.height = image.height ?? 0
        self.iso6391 = image.iso6391 ?? "N/A"
        self.voteAverage = image.voteAverage ?? 0
        self.voteCount = image.voteCount ?? 0
        self.width = image.width ?? 0
    }


    static private func posterImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        if path == "" {
            // Place holder image
            return URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Blank_portrait%2C_male_(rectangular).png/594px-Blank_portrait%2C_male_(rectangular).png")!
        } else {
            return URL(string: "\(baseUrl)\(size)\(path)")!
        }
    }
    

}
