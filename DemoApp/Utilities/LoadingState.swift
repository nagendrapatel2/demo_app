//
//  LoadingState.swift
//  DemoApp
//
//  Created by Nagendra on 31/08/23.
//

import Foundation
enum LoadingState<Value> {
    case loading
    case loaded
    case failed(Error)
}

