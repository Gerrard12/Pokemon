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
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func start() {
        let pokemonListVC = PokemonListViewController()
        pokemonListVC.pokemonSelected = { [weak self] pokemon in
            self?.showPokemonDetail(for: pokemon)
        }
        navigationController?.setViewControllers([pokemonListVC], animated: false)
    }
    
    func showPokemonDetail(for pokemon: Int) {
        let pokemonDetailVC = PokemonDetailViewController()
        navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
    
    
}
