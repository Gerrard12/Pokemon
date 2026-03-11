//
//  APIClient.swift
//  Pokemon
//
//  Created by B89 on 9/03/26.
//

import Foundation

final actor APIClient: APIClientProtocol {

    private let baseURL: String
    private let session: URLSession

    init(baseURL: String,
         session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func execute<T: RequestProtocol>(_ request: T) async -> Result<T.Response, NetworkError> {
        do {
            let urlRequest = try await URLRequestBuilder.build(
                baseURL: self.baseURL,
                request: request
            )
            let (data, response) = try await self.session.data(for: urlRequest)
            guard let http = response as? HTTPURLResponse else {
                return .failure(.invalidURL)
            }
            guard 200...299 ~= http.statusCode else {
                return .failure(.badRequestError)
            }
            let decoded = try JSONDecoder().decode(T.Response.self, from: data)
            return .success(decoded)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.defaultError)
        }
    }
}
