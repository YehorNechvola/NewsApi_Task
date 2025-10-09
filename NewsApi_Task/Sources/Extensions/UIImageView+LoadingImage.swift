//
//  UIImageView+LoadingImage.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(url: String, placeholder: UIImage? = nil) {
        let url = URL(string: url)
        
        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
