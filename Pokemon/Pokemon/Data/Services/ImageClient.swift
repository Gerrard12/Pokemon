//
//  ImageCliente.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation
import UIKit

protocol ImageClientProtocol {
    func loadImage(url: String) async -> Result<UIImage,NetworkError>
    var cache: ImageCache { get set }
}

final class ImageClient: ImageClientProtocol {
    var cache: ImageCache = ImageCache.shared

    func loadImage(url: String) async -> Result<UIImage,NetworkError> {
        if let cached = await cache.image(for: url) {
            return .success(cached)
        }
        guard let requestURL = URL(string: url) else {
            return .failure(.invalidURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: requestURL)
            guard let image = UIImage(data: data) else {
                return .failure(.decodingError)
            }
            await cache.insert(image, for: url)
            return .success(image)
        } catch {
            return .failure(.defaultError)
        }
    }
}
