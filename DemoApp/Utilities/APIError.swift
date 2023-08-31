//
//  APIError.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case other(String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Provided URL is invalid"
        case .other(let string):
            return string
        case .unknown:
            return nil
        }
    }
}

extension APIError: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self = .other(value)
    }
}
