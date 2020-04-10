//
//  MovieCollectionView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/9/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct MovieCollectionView: UIViewRepresentable {
    
    var allItems: [HomeSection:[MovieBundle]]
    var didSelectItem: ( (_ indexPath: IndexPath) -> () ) = {_ in} 
    var seeAllforSection: ( (_ section: HomeSection)->() ) = {_ in }
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: context.coordinator.createCompositionalLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(NowPlayingCell.self, forCellWithReuseIdentifier: NowPlayingCell.reuseId)
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseId)
        collectionView.register(UpcomingCell.self, forCellWithReuseIdentifier: UpcomingCell.reuseId)
        collectionView.register(PopularActorCell.self, forCellWithReuseIdentifier: PopularActorCell.reuseId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseId)
        
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: UIViewRepresentableContext<MovieCollectionView>) {
        
    }
    
    func makeCoordinator() -> MovieCollectionView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
        
        var parent: MovieCollectionView
        
        init(_ parent: MovieCollectionView) {
            self.parent = parent
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            print("Section count: \(parent.allItems.count)")
            return parent.allItems.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return parent.allItems[HomeSection.allCases[section]]?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section {
            case 0:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCell.reuseId, for: indexPath) as? NowPlayingCell {
                    cell.movie = parent.allItems[.NowPlaying]?[indexPath.item] as? MovieViewModel
                    return cell
                }
            case 1:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseId, for: indexPath) as? PopularCell {
                    cell.movie = parent.allItems[.Popular]?[indexPath.item] as? MovieViewModel
                    return cell
                }
            case 2:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCell.reuseId, for: indexPath) as? UpcomingCell {
                    cell.movie = parent.allItems[.Upcoming]?[indexPath.item] as? MovieViewModel
                    return cell
                }
            default:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularActorCell.reuseId, for: indexPath) as? PopularActorCell {
                    cell.actor = parent.allItems[.TopActor]?[indexPath.item] as? PersonViewModel
                    return cell
                }
            }
            return UICollectionViewCell()
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            parent.didSelectItem(indexPath)
        }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseId, for: indexPath) as? HeaderView else {
                    return UICollectionReusableView()
                }
                header.name.text = HomeSection.allCases[indexPath.section].rawValue
                header.onSeeAllClicked = { [weak self] in
                    print("%%% Click %$$$$")
                    self?.parent.seeAllforSection(HomeSection.allCases[indexPath.section])
                }
                return header
            default:
                return UICollectionReusableView()
            }
        }
        
        func createNowPlayingSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            layoutSection.boundarySupplementaryItems = [createSectionHeader()]
            return layoutSection
        }
        
        func createSharedSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.75))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            layoutSection.boundarySupplementaryItems = [createSectionHeader()]
            return layoutSection
        }
        
        func createUpcomingSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension:  .fractionalWidth(0.55))
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            layoutSection.boundarySupplementaryItems = [createSectionHeader()]
            return layoutSection
        }
        
        func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
            let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
            let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            return layoutSectionHeader
        }
        
        func createCompositionalLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout {[weak self] index, environment in
               switch index {
               case 0:
                  return self?.createNowPlayingSection()
               case 1:
                  return self?.createSharedSection()
               case 2:
                  return self?.createUpcomingSection()
               default:
                  return self?.createSharedSection()
               }
            }
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.interSectionSpacing = 20
            layout.configuration = config
            return layout
        }
        
    }
    
    
}
