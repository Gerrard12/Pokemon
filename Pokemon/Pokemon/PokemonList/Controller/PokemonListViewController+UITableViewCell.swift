//
//  PokemonListViewController+UITableViewCell.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation
import UIKit

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }
        cell.setup(item: viewModel.pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pokemonSelected?(viewModel.pokemons[indexPath.row])
    }
}
