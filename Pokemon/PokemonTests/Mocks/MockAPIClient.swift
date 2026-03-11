//
//  MockAPIClient.swift
//  PokemonTests
//
//  Created by B89 on 11/03/26.
//

import Testing
@testable import Pokemon

final class MockAPIClient: APIClientProtocol {

    var result: Any?

    func execute<T>(_ request: T) async -> Result<T.Response, NetworkError> where T : RequestProtocol {
        if let result = result as? T.Response {
            return .success(result)
        }
        return .failure(.defaultError)
    }
}
