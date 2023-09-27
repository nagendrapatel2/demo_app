//
//  LoadingState.swift
//  DemoApp
//
//  Created by Nagendra on 31/08/23.
//

import Foundation
enum LoadingState<Value> {
    case idle
    case loading
    case loaded
    case failed(Error)
}
extension LoadingState: Equatable where Value: Equatable {
    static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case let (.failed(error1), .failed(error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}
