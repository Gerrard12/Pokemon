//
//  ImageCache.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation
import UIKit

actor ImageCache {

    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()

    func image(for key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }

    func insert(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

