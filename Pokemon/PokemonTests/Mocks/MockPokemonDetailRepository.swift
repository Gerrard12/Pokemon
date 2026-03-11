//
//  MockPokemonDetailRepository.swift
//  PokemonTests
//
//  Created by B89 on 11/03/26.
//

import Foundation
@testable import Pokemon

final class MockPokemonDetailRepository: PokemonDetailRepositoryProtocol {

    var result: Result<PokemonDetail, NetworkError>!

    func fetchPokemonDetail(id: Int) async -> Result<PokemonDetail, NetworkError> {
        return result
    }
}
