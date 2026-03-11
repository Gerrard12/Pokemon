//
//  PokemonDetailViewModelTests.swift
//  PokemonTests
//
//  Created by B89 on 11/03/26.
//

@testable import Pokemon
import XCTest
import Foundation

@MainActor
final class PokemonDetailViewModelTests: XCTestCase {
    
    let repository = MockPokemonDetailRepository()
    let pokemon1 = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
    let imageClient = MockImageClient()

    func testLoadPokemonDetailSuccess() async {

        // Moqueamos la repuesta de un Json
        let json = """
        {
          "id": 1,
          "name": "bulbasaur",
          "height": 7,
          "weight": 69,
          "sprites": {
            "front_default": "image_url"
          }
        }
        """.data(using: .utf8)!
        let detail = try! JSONDecoder().decode(PokemonDetail.self, from: json)
        repository.result = .success(detail)

        let viewModel = PokemonDetailViewModel(pokemon: pokemon1, repository: repository, imageDownloader: ImageClient())
        await viewModel.getPokemonDetail()

        // Validamos los datos del pokemon
        XCTAssertEqual(viewModel.pokemonDetail.name, "bulbasaur")
        XCTAssertEqual(viewModel.pokemonDetail.height, 7)
    }
    
    func testLoadPokemonDetailFailure() async {

        repository.result = .failure(.defaultError)

        let viewModel = PokemonDetailViewModel(pokemon: pokemon1, repository: repository, imageDownloader: imageClient)
        await viewModel.getPokemonDetail()
        
        // Validamos de que no se hizo correctamente la carga de la data
        XCTAssertEqual(viewModel.pokemonDetail.name, "")
    }
    
    func testLoadPokemonImageSuccess() async {

        imageClient.result = .success(UIImage())

        let viewModel = PokemonDetailViewModel(pokemon: pokemon1, repository: repository, imageDownloader: imageClient)
        await viewModel.getImage()
        
        // Validamos de la imagen se cargue correctamente
        XCTAssertNotNil(viewModel.pokemonImage)
    }
    
    func testLoadPokemonImageFailure() async {

        imageClient.result = .failure(.invalidURL)

        let viewModel = PokemonDetailViewModel(pokemon: pokemon1, repository: repository, imageDownloader: imageClient)
        await viewModel.getImage()
        
        // Validamos de la imagen no haya sido cargada
        XCTAssertNil(viewModel.pokemonImage)
    }
    
    
}

