//
//  PokemonRepositoryTests.swift.swift
//  PokemonTests
//
//  Created by B89 on 11/03/26.
//

import Testing
@testable import Pokemon
import XCTest

@MainActor
final class PokemonRepositoryTests: XCTestCase {

    func testRepositoryFetchPokemons() async {
        let apiClient = MockAPIClient()

        apiClient.result = PokemonList(
            results: [
                Pokemon(name: "pikachu", url: "")
            ]
        )
        let repository = PokemonRepository(api: apiClient)
        let result = await repository.fetchPokemons()

        switch result {
        case .success(let response):
            XCTAssertEqual(response.results.count, 1)
        case .failure:
            Issue.record("Expected success")
        }
    }

}
