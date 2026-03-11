//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by B89 on 10/03/26.
//

import Foundation

struct PokemonDetail: Codable {
    
    let abilities: [Abilities]?
    let types: [Type]?
    let stats: [Stats]?
    let name: String?
    let height: Int?
    let weight: Int?
    
    init() {
        self.abilities = []
        self.types = []
        self.stats = []
        self.name = ""
        self.height = 0
        self.weight = 0
    }
    
    var totalAbilities: String {
        guard let abilities = self.abilities else {
            return ""
        }
        return abilities
            .compactMap { $0.ability?.name }
            .joined(separator: ", ")
    }
    
    var totalTypes: String {
        guard let types = self.types else {
            return ""
        }
        return types
            .compactMap { $0.type?.name }
            .joined(separator: ", ")
    }
}

struct Abilities: Codable {
    let ability: AbilityDetail?
}

struct AbilityDetail: Codable {
    let name: String?
}

struct Type: Codable {
    let type: TypeDetail?
    
}

struct TypeDetail: Codable {
    let name: String?
}

struct Stats: Codable {
    let baseStat: Int?
    let stat: StatDetail?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatDetail: Codable {
    let name: String?
}

