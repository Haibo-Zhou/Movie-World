//
//  ContentView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 2/13/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct MovieWorldAppView: View {
    
    @State private var section: HomeSection = .Popular
    
    @ObservedObject var model = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            
            if model.sectionMoviesBundle.isEmpty {
                Text("Loading...")
            } else {
                createCollectionView()
            }
            
        }.onAppear() {
            self.model.getSectionMoviesBundle()
        }
        
    }
    
    fileprivate func createCollectionView() -> some View {
        print("model.sectionMoviesBundle Count: \(model.sectionMoviesBundle)")
        return MovieCollectionView(allItems: model.sectionMoviesBundle, seeAllforSection: {section in} )
                .edgesIgnoringSafeArea(.all).navigationBarTitle("Movies")
    }
}

struct MovieWorldAppView_Previews: PreviewProvider {
    static var previews: some View {
        MovieWorldAppView()
    }
}

