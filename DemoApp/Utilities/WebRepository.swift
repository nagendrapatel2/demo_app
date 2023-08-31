//
//  WebRepository.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import Foundation

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension WebRepository {
    func request<T: Decodable>(endpoint: APIClient, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let urlRequest = try await authorizedRequest(from: endpoint)
        let (data, response) = try await session.data(for: urlRequest)
        try Task.checkCancellation()

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError("Invalid response")
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw APIError.other("Bad response: \(httpResponse.statusCode)")
        }

        return try decoder.decode(T.self, from: data)
    }

    func authorizedRequest(from endpoint: APIClient) async throws -> URLRequest {
        let urlRequest = try endpoint.urlRequest(baseURL: baseURL)
        try Task.checkCancellation()
        return urlRequest
    }
}
