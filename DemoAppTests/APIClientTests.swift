//
//  APIClientTests.swift
//  DemoAppTests
//
//  Created by Nagendra on 04/10/23.
//

import XCTest
@testable import DemoApp
final class APIClientTests: XCTestCase {
    
       func testURLRequestCreation() {
           let baseURL = "https://example.com"
           let apiClient = MockAPIClient(path: "/endpoint", method: "GET", headers: ["Authorization": "Bearer Token"])
           do {
               let request = try apiClient.urlRequest(baseURL: baseURL)
               XCTAssertEqual(request.httpMethod, "GET")
               XCTAssertEqual(request.url?.absoluteString, "https://example.com/endpoint")
               XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "Bearer Token")
           } catch {
               XCTFail("Failed to create URLRequest: \(error)")
           }
       }
       // Test case for creating a URLRequest with an invalid URL
       func testInvalidURL() {
           let baseURL = "invalidURL" // Invalid URL
           let apiClient = MockAPIClient(path: "/endpoint", method: "GET", headers: nil)
           do {
               _ = try apiClient.urlRequest(baseURL: baseURL)
           } catch let error {
               XCTAssertTrue(error is APIError)
               if let error =  error as? APIError {
                   guard case .invalidURL = error else {
                       XCTFail("Expected  invalidURL, but was \(error)")
                       return
                   }
               }
           }
       }
   }
