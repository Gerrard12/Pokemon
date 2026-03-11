//
//  MockImageClient.swift
//  PokemonTests
//
//  Created by B89 on 11/03/26.
//

import Foundation
import UIKit
@testable import Pokemon

final class MockImageClient: ImageClientProtocol {
    
    var cache: ImageCache = ImageCache.shared
    var result: Result<UIImage, NetworkError>!
    
    func loadImage(url: String) async -> Result<UIImage, NetworkError> {
        return result
    }

}
