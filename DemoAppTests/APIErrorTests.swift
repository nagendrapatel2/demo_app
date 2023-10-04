//
//  APIErrorTests.swift
//  DemoAppTests
//
//  Created by Nagendra on 04/10/23.
//

import XCTest
@testable import DemoApp
final class APIErrorTests: XCTestCase {
 
        func testInvalidURLDescription() {
            let error = APIError.invalidURL
            XCTAssertEqual(error.errorDescription, "Provided URL is invalid")
        }
        func testOtherDescription() {
            let customDescription = "Custom error description"
            let error: APIError = "Custom error description"
            XCTAssertEqual(error.errorDescription, customDescription)
        }
        func testUnknownDescription() {
            let error = APIError.unknown
            XCTAssertNil(error.errorDescription)
        }
    }
