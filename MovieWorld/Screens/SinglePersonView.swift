//
//  SingleActorView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/9/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SinglePersonView: View {
    
    var personId: Int = -1
    @ObservedObject var model = MovieListViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(model.person.name) // person Name
                PosterImage(person: model.person)
                Text(model.person.biography) // person bio
                
            }
        }.onAppear() {
            self.model.getPersonDetail(id: self.personId)
        }
    }
}

struct PosterImage: View {
    var person: PersonViewModel
    
    var body: some View {
        KFImage(source: .network(person.profileUrl))
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

struct SinglePersonView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePersonView()
    }
}
