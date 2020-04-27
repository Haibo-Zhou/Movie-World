//
//  ActorViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/9/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI


struct PersonViewModel: Identifiable, DummyBundle {
    var profileUrl: URL
    var adult: Bool
    var id: Int
    var name: String
    var popularity: CGFloat
    var knownFor: String
    var biography: String
    var placeOfBirth: String
    var imdbId: String
    var nameCn: String
    var biographyCn: String

    private let baseImageUrl = "https://image.tmdb.org/t/p/"
    private let backdropSize = "w780"
    private let posterSize = "w500"
    

    static var `default` : PersonViewModel {
        get {
            PersonViewModel(actor: Actor(profilePath: "", adult: false, id: 0, name: "", popularity: 0, knownFor: [],
                                         biography: "", placeOfBirth: "", imdbId: "", translations: Translation.default) )
        }
    }

    init(actor: Actor) {
        
        self.profileUrl = PersonViewModel.posterImageUrl(with: actor.profilePath ?? "", baseUrl: self.baseImageUrl, size: posterSize)
        self.adult = actor.adult
        self.id = actor.id!
        self.name = actor.name ?? "N/A"
        self.popularity = actor.popularity ?? 0
        self.knownFor = PersonViewModel.knownFor(actor: actor)
        self.biography = actor.biography ?? ""
        self.placeOfBirth = actor.placeOfBirth ?? ""
        self.imdbId = actor.imdbId ?? ""
        self.nameCn = actor.translations?.translations.filter{$0.iso31661 == "CN"}.first?.name ?? ""
        self.biographyCn = actor.translations?.translations.filter{$0.iso31661 == "CN"}.first?.data.biography ?? ""
    }


    static private func posterImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        
        if path == "" {
            // Place holder image
            return URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Blank_portrait%2C_male_(rectangular).png/594px-Blank_portrait%2C_male_(rectangular).png")!
        } else {
            return URL(string: "\(baseUrl)\(size)\(path)")!
        }
        
//        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
//            return url
//        }
//
//        return URL(string: "https://via.placeholder.com/150/0000FF/808080?Text=No&image&available")!
    }
    
    static private func knownFor(actor: Actor) -> String {
           
        if let knowForProductions = actor.knownFor, !knowForProductions.isEmpty {
            return knowForProductions.first?.title ?? knowForProductions.first?.name ?? "N/A"
        }
           
        return "N/A"
    }

}
