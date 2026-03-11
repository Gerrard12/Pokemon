//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation

@MainActor
final class PokemonViewModel {

    private let repository: PokemonRepositoryProtocol
    private var allPokemons: [Pokemon] = []
    private(set) var pokemons: [Pokemon] = [] {
         didSet { onPokemonsChanged?(pokemons) }
     }
    var onPokemonsChanged: (([Pokemon]) -> Void)?
    var onError: ((NetworkError) -> Void)?
    var onLoading: ((Bool) -> Void)?

    init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }

    func loadPokemons() async {
        onLoading?(true)
        let result = await repository.fetchPokemons()
        onLoading?(false)
        switch result {
        case .success(let pokemons):
            self.allPokemons = pokemons.results
            self.pokemons = pokemons.results
        case .failure(let error):
            onError?(error)
        }
    }
    
    func searchPokemon(by name: String) {
        guard !name.isEmpty else {
            pokemons = allPokemons
            return
        }
        pokemons = allPokemons.filter {
            $0.name.lowercased().contains(name.lowercased())
        }
    }
}
