//
//  PokemonRequest.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation

struct PokemonRequest: RequestProtocol {

    typealias Response = PokemonList

    var path: String { "/pokemon" }
    var method: HTTPMethod { .GET }
    var query: [URLQueryItem]? {
        [
            URLQueryItem(name: "limit", value: "151"),
            URLQueryItem(name: "offset", value: "0")
        ]
    }
    var body: Data? { nil }
    var headers: [String : String]? { nil }
}
