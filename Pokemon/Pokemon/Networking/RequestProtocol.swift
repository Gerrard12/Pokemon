//
//  Request.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import Foundation

protocol RequestProtocol {

    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var query: [URLQueryItem]? { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}
