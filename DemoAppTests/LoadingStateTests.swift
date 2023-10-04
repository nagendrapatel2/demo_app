//
//  LoadingStateTests.swift
//  DemoAppTests
//
//  Created by Nagendra on 04/10/23.
//

import XCTest
@testable import DemoApp
final class LoadingStateTests: XCTestCase {
    func testLoadingStateLoading() {
        let loadingState: LoadingState<Void> = .loading
        switch loadingState {
        case .loading:
            break
        default:
            XCTFail("Expected .loading state, but got \(loadingState)")
        }
    }
    
    func testLoadingStateLoaded() {
           let loadingState: LoadingState<Void> = .loaded
           switch loadingState {
           case .loaded:
               break
           default:
               XCTFail("Expected .loaded state, but got \(loadingState)")
           }
       }
    
    func testLoadingStateFailed() {
        let customError = NSError(domain: "YourDomain", code: 123, userInfo: nil)
        let loadingState: LoadingState<Int> = .failed(customError)
        switch loadingState {
        case .failed(let error):
            XCTAssertEqual(error as NSError, customError)
        default:
            XCTFail("Expected .failed state, but got \(loadingState)")
        }
    }
}
