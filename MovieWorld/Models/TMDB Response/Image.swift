//
//  Image.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/19/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import Foundation

struct TMDBImagesResult: Codable {
    let id: Int
    let backdrops: [Image]
    let posters: [Image]
}

struct Image: Codable {
    let aspectRatio: Float?
    let filePath: String?
    let height: Int?
    let iso6391: String?
    let voteAverage: Int?
    let voteCount: Int?
    let width: Int?
    
    static var `default`: Image {
        Image(aspectRatio: 0, filePath: "", height: 0, iso6391: "", voteAverage: 0, voteCount: 0, width: 0)
    }
}
