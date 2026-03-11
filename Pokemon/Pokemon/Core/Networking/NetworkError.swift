//
//  NetworkError.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badRequestError
    case decodingError
    case defaultError
}
