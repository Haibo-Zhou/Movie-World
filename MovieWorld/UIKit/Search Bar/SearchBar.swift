//
//  SearchBar.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/17/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var onTextChanged: (String) -> Void
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        var onTextChanged: (String) -> Void
        
        init(text: Binding<String>, onTextChanged: @escaping (String) -> Void) {
            _text = text
            self.onTextChanged = onTextChanged
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            onTextChanged(text)
        }
        
//        func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn: NSRange, replacementText: String) -> Bool {
//            if replacementText != "" {
//                self.model.getMovieSearchResults(for: replacementText)
//                return true
//            } else {
//                return false
//            }
//        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, onTextChanged: onTextChanged)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}


