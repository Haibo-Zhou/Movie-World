//
//  ImageViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/19/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI


struct ImageViewModel: MixedMovieBundle, Hashable { // Identifiable
    

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
    

    static var `default` : ImageViewModel {
        get {
            ImageViewModel(image: movieImage(aspectRatio: 0, filePath: "", height: 0, iso6391: "", voteAverage: 0, voteCount: 0, width: 0) )
        }
    }

    init(image: movieImage) {
        
        self.fileURL = ImageViewModel.backdropImageUrl(with: image.filePath ?? "", baseUrl: self.baseImageUrl, size: backdropSize)
        self.aspectRatio = image.aspectRatio ?? 0
        self.height = image.height ?? 0
        self.iso6391 = image.iso6391 ?? "N/A"
        self.voteAverage = image.voteAverage ?? 0
        self.voteCount = image.voteCount ?? 0
        self.width = image.width ?? 0
    }


//    static private func posterImageUrl(with path: String, baseUrl: String, size: String) -> URL {
//        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
//            return url
//        }
//
//        return URL(string: "https://via.placeholder.com/150/0000FF/808080?Text=No&image&available")!
//    }
    
    static private func backdropImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        if path == "" {
            //print("path is empty")
            // Place holder image
            return URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Blank_portrait%2C_male_(rectangular).png/594px-Blank_portrait%2C_male_(rectangular).png")!
        } else {
            return URL(string: "\(baseUrl)\(size)\(path)")!
        }
    }

}
