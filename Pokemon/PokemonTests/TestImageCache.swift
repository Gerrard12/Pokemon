//
//  TestImageCache.swift
//  PokemonTests
//
//  Created by B89 on 11/03/26.
//

import Testing
@testable import Pokemon
import XCTest

@MainActor
final class TestImageCache: XCTestCase{

    func testImageCacheStoresAndRetrievesImage() async throws {
        let cache = ImageCache.shared
        let image = UIImage(systemName: "star")!

        await cache.insert(image, for: "test")
        let cachedImage = await cache.image(for: "test")
        // Validamos que la imagen se recupere correctamente
        XCTAssertNotNil(cachedImage != nil)
    }
}
