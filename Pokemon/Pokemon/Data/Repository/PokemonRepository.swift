//
//  PokemonRepository.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func fetchPokemons() async -> Result<PokemonList, NetworkError>
}


final class PokemonRepository: PokemonRepositoryProtocol {
    private let api: APIClientProtocol

    init(api: APIClientProtocol) {
        self.api = api
    }

    func fetchPokemons() async -> Result<PokemonList, NetworkError> {
        await api.execute(PokemonRequest())
    }

}
