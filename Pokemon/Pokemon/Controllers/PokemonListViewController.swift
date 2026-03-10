//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    //Para navegar al detalle del pokemon, por ahora solo le pasamos el ID luego lo reemplazaremos por el modelo.
    var pokemonSelected: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = "Lista de Pokemones"
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
