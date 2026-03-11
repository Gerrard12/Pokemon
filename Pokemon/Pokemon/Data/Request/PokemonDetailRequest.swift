//
//  PokemonDetailRequest.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//
import Foundation

struct PokemonDetailRequest: RequestProtocol {

    typealias Response = PokemonDetail
    let id: Int
    
    var path: String { "/pokemon/\(id)" }
    var method: HTTPMethod { .GET }
    var query: [URLQueryItem]? { nil }
    var body: Data? { nil }
    var headers: [String : String]? { nil }
}

