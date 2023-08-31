//
//  APIClient.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//


import Foundation

protocol APIClient {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

extension APIClient {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        request.httpShouldHandleCookies = false
        return request
    }
}
