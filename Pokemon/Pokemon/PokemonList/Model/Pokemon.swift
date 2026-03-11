//
//  PokemonItem.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation

struct Pokemon: Decodable {
    
    let name: String
    let url: String
    // Obtenemos el ID del pokemon
    var id: Int? {
        url
            .split(separator: "/")
            .last
            .flatMap { Int($0) }
    }
}

struct PokemonList: Decodable {
    let results: [Pokemon]
}
