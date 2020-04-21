//
//  PageView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/20/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage: Int
    
    init(_ views: [Page], selectedIdx: Int) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        _currentPage = State(initialValue: selectedIdx)
    }
    
    var body: some View {
        PageViewController(controllers: viewControllers, currentPage: $currentPage)
    }
}

//struct PageView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageView(features.map { FeatureCard(landmark: $0) })
//            .aspectRatio(3/2, contentMode: .fit)
//    }
//}



