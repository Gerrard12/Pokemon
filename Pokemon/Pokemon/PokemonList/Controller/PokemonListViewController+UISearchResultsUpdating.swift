//
//  PokemonListViewController+UISearchResultsUpdating.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//
import Foundation
import UIKit

extension PokemonListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        viewModel.searchPokemon(by: searchText)
    }
}
