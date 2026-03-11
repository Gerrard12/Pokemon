//
//  MockPokemonRepository.swift
//  PokemonTests
//
//  Created by B89 on 11/03/26.
//

import Testing

@testable import Pokemon

final class MockPokemonRepository: PokemonRepositoryProtocol {

    var result: Result<PokemonList, NetworkError>!

    func fetchPokemons() async -> Result<PokemonList, NetworkError> {
        result
    }
}
