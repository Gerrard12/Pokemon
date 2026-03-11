//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation
import UIKit

@MainActor
class PokemonDetailViewModel {
    
    private let pokemon: Pokemon
    private let repository: PokemonDetailRepositoryProtocol
    private let imageDownloader: ImageClientProtocol
    private(set) var pokemonDetail: PokemonDetail = PokemonDetail() {
         didSet { onPokemonDetailChanged?(pokemonDetail) }
     }
    var onPokemonDetailChanged: ((PokemonDetail) -> Void)?
    var onError: ((NetworkError) -> Void)?
    var onLoading: ((Bool) -> Void)?
    var onUpdateImage: ((UIImage?) -> Void)?
    var pokemonImage: UIImage? {
        didSet { onUpdateImage?(pokemonImage) }
    }
    
    init(pokemon: Pokemon,
         repository: PokemonDetailRepositoryProtocol,
         imageDownloader: ImageClientProtocol) {
        self.pokemon = pokemon
        self.repository = repository
        self.imageDownloader = imageDownloader
    }
    
    func getInformation() async {
        onLoading?(true)
        await getPokemonDetail()
        await getImage()
        onLoading?(false)
    }
    
    func getPokemonDetail() async {
        onLoading?(true)
        let result = await repository.fetchPokemonDetail(id: self.pokemon.id ?? 0)
        switch result {
        case .success(let pokemonDetail):
            self.pokemonDetail = pokemonDetail
        case .failure(let error):
            onError?(error)
        }
    }
    
    func getImage() async {
        // Por temas de tiempo, se semi-hardcodea la url para descargar la imagen
        let urlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id ?? 0).png"
        let result = await imageDownloader.loadImage(url: urlString)
        onLoading?(false)
        switch result {
        case .success(let image):
            self.pokemonImage = image
        case .failure(let error):
            onError?(error)
        }
    }
  
}
