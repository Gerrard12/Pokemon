//
//  AppCoordinator.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController?
    private let apiClient: APIClient
    
    init(navigationController: UINavigationController? = nil,
         apiClient: APIClient) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func start() {
        let repository = PokemonRepository(api: apiClient)
        let viewModel = PokemonViewModel(repository: repository)
        let pokemonListVC = PokemonListViewController(viewModel: viewModel)
        pokemonListVC.pokemonSelected = { [weak self] pokemon in
            self?.showPokemonDetail(for: pokemon)
        }
        navigationController?.setViewControllers([pokemonListVC], animated: false)
    }
    
    func showPokemonDetail(for pokemon: Pokemon) {
        let repository = PokemonDetailRepository(api: apiClient)
        let viewModel = PokemonDetailViewModel(pokemon: pokemon, repository: repository, imageDownloader: ImageClient())
        let pokemonDetailVC = PokemonDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
    
    
}
