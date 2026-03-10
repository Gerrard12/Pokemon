//
//  URLRequest.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import Foundation

struct URLRequestBuilder {

    static func build(baseURL: String,
                      request: some RequestProtocol) throws -> URLRequest {

        guard var components = URLComponents(string: baseURL + request.path) else {
            throw NetworkError.invalidURL
        }
        components.queryItems = request.query
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return urlRequest
    }
}
