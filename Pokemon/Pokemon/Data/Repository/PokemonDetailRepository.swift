//
//  PokemonDetailRepository.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation

protocol PokemonDetailRepositoryProtocol {
    func fetchPokemonDetail(id: Int) async -> Result<PokemonDetail, NetworkError>
}


final class PokemonDetailRepository: PokemonDetailRepositoryProtocol {
    private let api: APIClientProtocol

    init(api: APIClientProtocol) {
        self.api = api
    }

    func fetchPokemonDetail(id: Int) async -> Result<PokemonDetail, NetworkError> {
        await api.execute(PokemonDetailRequest(id: id))
    }

}
