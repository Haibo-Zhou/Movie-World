//
//  PersonImages.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/10/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import Foundation

struct PersonImages: Codable {
    let id: Int
    let profiles: [Profile]
}

struct Profile: Codable {
    let aspectRatio: Float?
    let filePath: String?
    let height: Int?
    let iso6391: String?
    let voteAverage: Float?
    let voteCount: Int?
    let width: Int?
    
    static var `default`: Profile {
        Profile(aspectRatio: 0, filePath: "", height: 0, iso6391: "", voteAverage: 0, voteCount: 0, width: 0)
    }
}
