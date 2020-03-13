//
//  ActorViewModel.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/9/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI



struct ActorViewModel: Identifiable, MovieBundle {

     var profileUrl: URL
     var adult: Bool
     var id: Int
     let name: String
     var popularity: CGFloat
     var knownFor: String

     private let baseImageUrl = "https://image.tmdb.org/t/p/"
     private let backdropSize = "w780"
     private let posterSize = "w342"
    

    static var `default` : ActorViewModel {
        get {
            ActorViewModel(actor: Actor(profilePath: "", adult: false, id: 0, name: "", popularity: 0, knownFor: []) )
        }
    }

    init(actor: Actor) {
        
        self.profileUrl = ActorViewModel.posterImageUrl(with: actor.profilePath ?? "", baseUrl: self.baseImageUrl, size: posterSize)
        self.adult = actor.adult
        self.id = actor.id!
        self.name = actor.name ?? "N/A"
        self.popularity = actor.popularity ?? 0
        self.knownFor = ActorViewModel.knownFor(actor: actor)
    }


    static private func posterImageUrl(with path: String, baseUrl: String, size: String) -> URL {
        if let url = URL(string: "\(baseUrl)\(size)\(path)"){
            return url
        }

        return URL(string: "https://via.placeholder.com/150/0000FF/808080?Text=No&image&available")!
    }
    
    static private func knownFor(actor: Actor) -> String {
           
        if let knowForProductions = actor.knownFor, !knowForProductions.isEmpty {
            return knowForProductions.first?.title ?? knowForProductions.first?.name ?? "N/A"
        }
           
        return "N/A"
    }

}
