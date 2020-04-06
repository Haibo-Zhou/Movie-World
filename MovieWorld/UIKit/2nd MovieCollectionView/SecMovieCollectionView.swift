//
//  CreditsCollectionView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/18/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI

struct SecMovieCollectionView: UIViewRepresentable {

    var allItems: [SecHomeSection:[MixedMovieBundle]]
    //var didSelectItem: ( (_ indexPath: IndexPath) -> () ) = {_ in}
    var seeAllforSection: ( (_ section: SecHomeSection)->() ) = {_ in }

    func makeUIView(context: Context) -> UICollectionView {

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: context.coordinator.createCompositionalLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(CrewCell.self, forCellWithReuseIdentifier: CrewCell.reuseId)
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.reuseId)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseId)

        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.isScrollEnabled = false

        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {

    }

    func makeCoordinator() -> SecMovieCollectionView.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

        var parent: SecMovieCollectionView

        init(_ parent: SecMovieCollectionView) {
            self.parent = parent
        }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            print("all items count: \(parent.allItems.count)")
            return parent.allItems.count
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            let aa = parent.allItems[.Director]
            return parent.allItems[SecHomeSection.allCases[section]]?.count ?? 0
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section {
            case 0:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewCell.reuseId, for: indexPath) as? CrewCell {
                    cell.crew = parent.allItems[.Director]?[indexPath.item] as? CrewViewModel
                    return cell
                }
            case 1:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.reuseId, for: indexPath) as? CastCell {
                    cell.cast = parent.allItems[.Cast]?[indexPath.item] as? CastViewModel
                    return cell
                }
            case 2:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as? ImageCell {
                    cell.image = parent.allItems[.Images]?[indexPath.item] as? ImageViewModel
                    return cell
                }
            default:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseId, for: indexPath) as? PopularCell {
                    cell.movie = parent.allItems[.Recomm]?[indexPath.item] as? MovieViewModel
                    return cell
                }
            }
            return UICollectionViewCell()
        }

//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            parent.didSelectItem(indexPath)
//        }

        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseId, for: indexPath) as? HeaderView else {
                    return UICollectionReusableView()
                }
                header.name.text = SecHomeSection.allCases[indexPath.section].rawValue
                header.onSeeAllClicked = { [weak self] in
                    print("%%% Click in SecCollectionView %$$$$")
                    self?.parent.seeAllforSection(SecHomeSection.allCases[indexPath.section])
                }
                return header
            default:
                return UICollectionReusableView()
            }
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

        func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
            let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
            let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            return layoutSectionHeader
        }

        func createCompositionalLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout {[weak self] index, environment in
               switch index {
               case 0:
                  return self?.createSharedSection()
               case 1:
                  return self?.createSharedSection()
               case 2:
                  return self?.createSharedSection()
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
