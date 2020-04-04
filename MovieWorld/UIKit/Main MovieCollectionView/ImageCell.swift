//
//  ImageCell.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/19/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

class ImageCell: UICollectionViewCell {
    static let reuseId: String = "ImageCell"
    
    var image: ImageViewModel? {
        didSet{
            if let image = self.image {
                // This line use kingFisher to download, set the image to the image view and caching it at the same time
                imageView.kf.setImage(with: image.fileURL)
                // titleLabel.text = image.name
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "adastra.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Ad Astra"
//        label.textColor = UIColor(named: "textColor")
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 2
//        label.textColor = .secondaryLabel
//        return label
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setupCell(){
        
        self.addSubview(self.imageView)
       // self.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: (3/2)),
            
//            titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            titleLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
}
