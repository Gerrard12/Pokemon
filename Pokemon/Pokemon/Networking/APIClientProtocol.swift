//
//  ApiClientProtocol.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//
import Foundation

protocol APIClientProtocol {
    func execute<T: RequestProtocol>(_ request: T) async -> Result<T.Response, NetworkError>
}
