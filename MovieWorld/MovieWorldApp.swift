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
    @State private var selectedIndexPath: IndexPath?
    @State private var showSheet = false
    
    @ObservedObject var model = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            
            if model.sectionMoviesBundle.isEmpty {
                Text("Loading...")
            } else {
                createCollectionView()
                    .sheet(isPresented: $showSheet) {
                        if self.selectedIndexPath == nil {
                            Text("MovieListView")
                        } else {
                            if self.section == .TopActor {
                                SinglePersonView(personId: (self.model.sectionMoviesBundle[self.section] as! [PersonViewModel])[self.selectedIndexPath!.item].id )
                            } else {
                                SingleMovieView(movieId: (self.model.sectionMoviesBundle[self.section] as! [MovieViewModel] ) [self.selectedIndexPath!.item].id )
                            }
                        }
                    }
            }
            
        }.onAppear() {
            self.model.getSectionMoviesBundle()
        }
        
    }
    
    fileprivate func createCollectionView() -> some View {
        // print("model.sectionMoviesBundle Count: \(model.sectionMoviesBundle)")
        return MovieCollectionView(allItems: model.sectionMoviesBundle,
                                   didSelectItem: { indexPath in
                                    self.selectedIndexPath = indexPath
                                    self.section = HomeSection.allCases[indexPath.section]
                                    self.showSheet.toggle()
                                    
        },
                                   seeAllforSection: { section in
                                    // self.section = section
                                    self.showSheet.toggle()
                                    self.selectedIndexPath = nil
        } )
                .edgesIgnoringSafeArea(.all).navigationBarTitle("Movies")
    }
}

struct MovieWorldAppView_Previews: PreviewProvider {
    static var previews: some View {
        MovieWorldAppView()
    }
}

