//
//  ImageScrollView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/16/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct ImageScrollView<Content: View>: UIViewControllerRepresentable {
    var content: () -> Content
    var hideScrollIndicators: Bool = false

    init(hideScrollIndicators: Bool, @ViewBuilder content: @escaping () -> Content) {
      self.content = content
      self.hideScrollIndicators = hideScrollIndicators
    }

    func makeUIViewController(context: Context) -> ScrollViewController<Content> {
      let vc = ScrollViewController(rootView: self.content())
      vc.hideScrollIndicators = hideScrollIndicators
      return vc
    }

    func updateUIViewController(_ viewController: ScrollViewController<Content>, context: Context) {
      viewController.hostingController.rootView = self.content()
    }
    
    
    
}
