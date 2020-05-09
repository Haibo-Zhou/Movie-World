//
//  SingleActorView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/9/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import GoogleMobileAds

struct SinglePersonView: View {
    
    var personId: Int = -1
    var isDirector = false
    @ObservedObject var model = MovieListViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                PosterImage(person: model.person)
                PersonDetailView(person: model.person)
                
                // For Firebase mobile Ads
                BannerView()
                    .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
                
                if model.personInfoBundle.isEmpty {
                    LoadingView().frame(width: 50, height: 50)
                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        if isDirector {
                            AttendedMovieList(movies: model.personInfoBundle[.DirectedMovies] as! [PersonMovieViewModel])
                        } else {
                            AttendedMovieList(movies: model.personInfoBundle[.CastedMovies] as! [PersonMovieViewModel])
                        }
                        PersonImageList(images: model.personInfoBundle[.Images] as! [PersonImageViewModel])
                    }
                }
            }
        }.edgesIgnoringSafeArea(.top)
            .onAppear() {
                self.model.getPersonDetail(id: self.personId)
                self.model.getPersonDetailBundle(id: self.personId)
        }
    }
}

private struct PersonDetailView: View {
    var person: PersonViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(person.name) // person Name
                .font(.system(size: 35, weight: .black, design: .rounded))
            createPersonBio()
        }.padding(.horizontal).padding(.bottom)
    }
    
    private func createPersonBio() -> some View {
        if let currentDeviceLanguage = Bundle.main.preferredLocalizations.first {
            if currentDeviceLanguage == "zh-Hans" {
                if self.person.biographyCn != "" {
                    return Text(self.person.biographyCn)
                        .font(.body)
                }
            }
        }
        return Text(self.person.biography)
            .font(.body)
    }
}

private struct PosterImage: View {
    var person: PersonViewModel
    
    var body: some View {
        KFImage(source: .network(person.profileUrl))
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

private struct AttendedMovieList: View {
    var movies: [PersonMovieViewModel]
    @State private var showSheet = false
    @State private var selectedID = -1
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Known For")
                .font(.headline)
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(movies) { movie in
                        VStack(alignment: .leading) {
                            KFImage(source: .network(movie.posterURL))
                                .resizable()
                                .frame(width: 100, height: 150)
                                .aspectRatio(2/3, contentMode: .fill)
                                .onTapGesture {
                                    self.selectedID = movie.id
                                    self.showSheet.toggle()
                            }
                            Text("\(movie.title)")
                                .lineLimit(2)
                                .foregroundColor(.gray)
                                .frame(height: 50, alignment: .top)
                        }.frame(width: 100)
                    }
                }
                
            }.sheet(isPresented: self.$showSheet) {
                SingleMovieView(movieId: self.selectedID)
            }
        }.padding(.horizontal).padding(.bottom)
    }
}

private struct PersonImageList: View {
    var images: [PersonImageViewModel]
    @State private var showSheet = false
    @State private var selectedIdx = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ImagesSectionTitle")
                .font(.headline)
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 6) {
                    ForEach(0..<images.count, id: \.self) { i in
                        KFImage(source: .network(self.images[i].fileURL))
                            .resizable()
                            .frame(width: 100, height: 150)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                self.selectedIdx = i
                                self.showSheet.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showSheet) {
                    if self.images.count == 1 {
                        PresentedImageView(image: self.images[0])
                    } else {
                        PageView(self.images.map { PresentedImageView(image: $0) }, selectedIdx: self.selectedIdx)
                    }
                }
            }.frame(height: 150)
        }
        .padding(.horizontal).padding(.bottom)
    }
}

private struct PresentedImageView: View {
    var image: PersonImageViewModel
    
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

struct SinglePersonView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePersonView()
    }
}
