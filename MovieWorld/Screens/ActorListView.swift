//
//  ActoreListView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/15/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct ActorListView: View {
    
    var section: HomeSection
    @ObservedObject var model = MovieListViewModel()
    @State private var page = 1
    @State private var showSheet = false
    @State private var selectedId = -1
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<model.paginatedActors.count, id: \.self) { i in
                    ActorListRow(actor: self.model.paginatedActors[i])
                        .onTapGesture {
                            self.selectedId = self.model.paginatedActors[i].id
                            self.showSheet.toggle()
                    }
                        .onAppear() {
                            if i == self.model.paginatedActors.count - 1 {
                                self.page += 1
                                self.model.getPaginatedActors(for: self.page)
                            }
                    }
                }
            }.navigationBarTitle(NSLocalizedString(section.rawValue, comment: ""))
                .sheet(isPresented: $showSheet) {
                    SinglePersonView(personId: self.selectedId)
            }
        }.onAppear() {
            self.model.getPaginatedActors(for: self.page)
        }
    }
}

struct ActorListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(section: .NowPlaying)
    }
}
