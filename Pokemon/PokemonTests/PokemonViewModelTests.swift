//
//  PokemonViewModelTests.swift
//  PokemonTests
//
//  Created by B89 on 11/03/26.
//

import Testing
@testable import Pokemon
import XCTest

@MainActor
final class PokemonViewModelTests: XCTestCase {
    
    let repository = MockPokemonRepository()

    func testLoadPokemonsSuccess() async {

        repository.result = .success(
            PokemonList(
                results: [
                    Pokemon(name: "pikachu",
                            url: "https://pokeapi.co/api/v2/pokemon/25/")
                ]
            )
        )
        let viewModel = PokemonViewModel(repository: repository)
        await viewModel.loadPokemons()
        // Validamos que la carga de datos sea correcta
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "pikachu")
    }
    
    func testLoadPokemonsFailure() async {

        repository.result = .failure(.defaultError)
        let viewModel = PokemonViewModel(repository: repository)
        await viewModel.loadPokemons()
        // Validamos que no se haya cargado ningun pokemon
        XCTAssertEqual(viewModel.pokemons.count, 0)
    }


    func testSearchPokemonFiltersSuccess() async {

        repository.result = .success(
            PokemonList(results: [
                Pokemon(name: "pikachu", url: ""),
                Pokemon(name: "bulbasaur", url: ""),
                Pokemon(name: "charmander", url: "")
            ])
        )

        let viewModel = PokemonViewModel(repository: repository)
        await viewModel.loadPokemons()
        viewModel.searchPokemon(by: "bulb")
        // Validamos que la busqueda sea exitosa
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "bulbasaur")
    }
    
    func testSearchEmptyRestoresList() async {

        repository.result = .success(
            PokemonList(results: [
                Pokemon(name: "pikachu", url: ""),
                Pokemon(name: "bulbasaur", url: "")
            ])
        )

        let viewModel = PokemonViewModel(repository: repository)
        await viewModel.loadPokemons()
        viewModel.searchPokemon(by: "pika")
        viewModel.searchPokemon(by: "")
        // Validamos que se muestre toda la lista, al no tener un texto en la busqueda
        XCTAssertEqual(viewModel.pokemons.count, 2)
    }
    
    func testSearchEmptyResultList() async {

        repository.result = .success(
            PokemonList(results: [
                Pokemon(name: "pikachu", url: ""),
                Pokemon(name: "bulbasaur", url: "")
            ])
        )

        let viewModel = PokemonViewModel(repository: repository)
        await viewModel.loadPokemons()
        viewModel.searchPokemon(by: "char")
        // Validamos que no se muestre resultados
        XCTAssertEqual(viewModel.pokemons.count, 0)
    }
    
    func testOnPokemonsChangedCallback() async {

        let repository = MockPokemonRepository()
        repository.result = .success(
            PokemonList(results: [
                Pokemon(name: "pikachu", url: "")
            ])
        )

        let viewModel = PokemonViewModel(repository: repository)
        let expectation = expectation(description: "callback")

        viewModel.onPokemonsChanged = { pokemons in
            XCTAssertEqual(pokemons.count, 1)
            expectation.fulfill()
        }
        // Validamos que la comunicacion del callback sea correcta
        await viewModel.loadPokemons()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
}
