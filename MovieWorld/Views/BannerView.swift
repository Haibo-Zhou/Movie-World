//
//  BannerView.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 4/28/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMobileAds

struct BannerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        let viewController = UIViewController()
        // real Ad ID
//        view.adUnitID = "xxxxxx-xxxx"
        // test Ad ID
        view.adUnitID = "xxxxx-xxxxxx"
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
}


