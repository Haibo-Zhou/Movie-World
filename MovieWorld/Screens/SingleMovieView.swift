//
//  SingleMovieView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/16/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import GoogleMobileAds

struct SingleMovieView: View {

    var movieId: Int = -1
    @ObservedObject var model = MovieListViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading)  {
                createPosterImage()
                MovieDetailView(movie: self.model.movie)
                
                // For Firebase mobile Ads
                BannerView()
                    .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)

                if model.movieDetailBundle.isEmpty {
                    LoadingView().frame(width: 30, height: 30)
                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        CrewList(crews: (model.movieDetailBundle[.Crew] as! [CrewViewModel]).filter {$0.job == "Director"} )
                        CastList(casts: model.movieDetailBundle[.Cast] as! [CastViewModel])
                        ImageList(images: model.movieDetailBundle[.Images] as! [ImageViewModel])
                        RecMovieList(movies: model.movieDetailBundle[.Recomm] as! [MovieViewModel], model: self.model)
                    }
                }
            }
        }.edgesIgnoringSafeArea(.top)
        .onAppear() {
                self.model.getMovieDetail(id: self.movieId)
                self.model.getMovieDetailBundle(id: self.movieId)
        }
    }
    fileprivate func createPosterImage() -> some View {
        return KFImage(source: .network(model.movie.posterUrl))
            .resizable().aspectRatio(contentMode: .fit)
    }
}

struct CrewList: View {
    
    var crews: [CrewViewModel]
    @State private var showSheet = false
    @State private var selectedID = -1
    @State private var isDirector = true

    var body: some View {

        VStack(alignment: .leading) {
            Text("DirectorSectionTitle")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 6) {
                    ForEach(crews, id: \.self) { crew in
                        VStack(alignment: .leading) {
                            KFImage(source: .network(crew.profileUrl))
                            .resizable()
                            .frame(maxWidth: 100, maxHeight: 150)
                            .aspectRatio(2/3, contentMode: .fill)
                            .cornerRadius(5)
                                .onTapGesture {
                                    self.selectedID = crew.id
                                    self.showSheet.toggle()
                            }
                            
                            Text("\(crew.name)")
                            .lineLimit(nil)
                            .foregroundColor(.gray)
                        }
                        //.frame(width: 100)
                    }
                }.sheet(isPresented: $showSheet) {
                    SinglePersonView(personId: self.selectedID, isDirector: self.isDirector)
                }
            }.frame(height: 180)
        }
        .padding(.horizontal).padding(.bottom)
    }
}

struct CastList: View {
    var casts: [CastViewModel]
    @State private var showSheet = false
    @State private var selectedID = -1

    var body: some View {
        
        VStack(alignment: .leading) {
            Text("CastSectionTitle")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 6) {
                    ForEach(casts, id: \.self) { cast in
                        VStack(alignment: .leading) {
                            KFImage(source: .network(cast.profileUrl))
                                .resizable()
                                .frame(width: 100, height: 150)
                                .aspectRatio(2/3, contentMode: .fill)
                                .cornerRadius(5)
                                .onTapGesture {
                                    self.selectedID = cast.id
                                    self.showSheet.toggle()
                            }
                            
                            Text("\(cast.name)")
                            .lineLimit(2)
                            .foregroundColor(.gray)
                                .frame(height: 50, alignment: .top)

                        }.frame(width: 100)
                    }
                }.sheet(isPresented: $showSheet) {
                    SinglePersonView(personId: self.selectedID, isDirector: false)
                }
            }
        }
        .padding(.horizontal).padding(.bottom)
    }
}

private struct ImageList: View {
    var images: [ImageViewModel]
    @State private var showSheet = false
    @State private var selectedIdx = 0

    var body: some View {

        VStack(alignment: .leading) {
            Text("ImagesSectionTitle")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 6) {
                    ForEach(0..<images.count, id: \.self) { i in
                        KFImage(source: .network(self.images[i].fileURL))
                            .resizable()
                            .frame(width: 200)
                            .aspectRatio(1.77, contentMode: .fit)
                            .onTapGesture {
                                self.selectedIdx = i
                                self.showSheet.toggle()
                        }
                    }
                }.sheet(isPresented: $showSheet) {
                    if self.images.count == 1 {
                        PresentedImageView(image: self.images[0])
                    } else {
                        PageView(self.images.map { PresentedImageView(image: $0) }, selectedIdx: self.selectedIdx)
                    }
                }
            }.frame(height: 120)
        }
        .padding(.horizontal).padding(.bottom)
    }
}

private struct PresentedImageView: View {
    var image: ImageViewModel
    
    @State private var contentMode: ContentMode = .fit
    @State private var scaleAmount: CGFloat = 1.0
    @State private var dragAmount: CGSize = .zero
    @State private var offSetAmount: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            KFImage(source: .network(image.fileURL))
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .offset(dragAmount)
                .scaleEffect(scaleAmount)
                .onTapGesture(count: 2) { // double clicking zoom in/out
                    withAnimation(.spring()) {
                        (self.contentMode == .fit) ?
                            (self.contentMode = .fill) :
                            (self.contentMode = .fit)
                    }
            }
            // For double fingers zoom in/out
            .gesture(
                MagnificationGesture(minimumScaleDelta: 0.05)
                    .onChanged { self.scaleAmount = $0 }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            self.scaleAmount = 1.0
                            self.dragAmount = .zero
                            self.offSetAmount = .zero
                        }
                }
            .simultaneously(with:
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in withAnimation(.spring()) {
                        self.scaleAmount = 1.0
                        self.dragAmount = .zero
                        self.offSetAmount = .zero
                        }
                    }
                )
            )
        }
    }
}

struct RecMovieList: View {
    
    var movies: [MovieViewModel]
    var model: MovieListViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(NSLocalizedString(MovieDetailSection.Recomm.rawValue, comment: ""))")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(movies) { movie in
                        VStack(alignment: .leading) {
                            KFImage(source: .network(movie.posterUrl))
                                .resizable()
                                .frame(width: 100, height: 150)
                                .aspectRatio(2/3, contentMode: .fill)
                                .onTapGesture {
                                    withAnimation(.default) {
                                        self.model.getMovieDetail(id: movie.id)
                                        self.model.getMovieDetailBundle(id: movie.id)
                                    }
                                }
                            Text("\(movie.title)")
                            .lineLimit(2)
                            .foregroundColor(.gray)
                            .frame(height: 50, alignment: .top)

                        }.frame(width: 100)
                    }
                }
            }
        }
        .padding(.horizontal).padding(.bottom)
    }
}


