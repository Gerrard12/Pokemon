//
//  InitialConfiguration.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import Foundation

// Asiganamos el basdeURL segun el ambiente
enum InitialConfiguration {
    static var baseURL: String {
        #if Release
        return ""
        #else
        return "https://pokeapi.co/api/v2"
        #endif
    }
}
