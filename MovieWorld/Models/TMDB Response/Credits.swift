//
//  Credits.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/18/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import Foundation

struct Credits: Codable {
    let id: Int?
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable {
    let castId: Int?
    let character: String?
    let creditId: String?
    let gender: Int?
    let id: Int?
    let name: String?
    let order: Int?
    let profilePath: String?
    
    static var `default`: Cast {
        Cast(castId: 0, character: "", creditId: "", gender: 0, id: 0, name: "", order: 0, profilePath: "")
    }
}

struct Crew: Codable {
    let creditId: String?
    let department: String?
    let gender: Int?
    let id: Int?
    let job: String?
    let name: String?
    let profilePath: String?
    
    static var `default`: Crew {
        Crew(creditId: "", department: "", gender: 0, id: 0, job: "", name: "", profilePath: "")
    }
}
