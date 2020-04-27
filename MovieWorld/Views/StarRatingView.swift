//
//  StarRatingView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/27/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

// MARK: stars rating view
struct StarRatingView: View {
    var ratingScore: Double
    var intPart: Int { Int( modf(ratingScore/2).0 ) }
    var fracPart: Double { modf(ratingScore/2).1 }
    var usedInMovieList: Bool
    
    var body: some View {
        HStack {
            HStack(spacing: 2) {
                ForEach(0..<intPart, id: \.self) { score in
                    self.getStarImage(starTypeName: "star.fill")
                }
                
                if fracPart != 0.0 && fracPart < 0.5 {
                    self.getStarImage(starTypeName: "star.lefthalf.fill")
                }
                else if fracPart != 0.0 && fracPart >= 0.5 {
                    self.getStarImage(starTypeName: "star.fill")
                }
            }
            if usedInMovieList {
                Text(String(ratingScore))
                .font(.body)
                .foregroundColor(.gray)
            }
        }
    }
    
    private func getStarImage(starTypeName: String) -> some View {
           
        return Image(systemName: starTypeName)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .foregroundColor(.orange)
               .frame(maxWidth: 12)
    }
}
