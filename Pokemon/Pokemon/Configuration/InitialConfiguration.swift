//
//  InitialConfiguration.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import Foundation

enum InitialConfiguration {
    static var basURL: String {
        #if Release
        return ""
        #else
        return "https://pokeapi.co/api/v2"
        #endif
    }
}
