//
//  UITestingHelper.swift
//  DemoApp
//
//  Created by Nagendra on 27/09/23.
//

#if DEBUG
import Foundation
struct UITestingHelper {
    static var isPreview : Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    static var isUITesting : Bool {
        ProcessInfo.processInfo.arguments.contains("_ui_testing")
    }
    static var isNetworkSuccess : Bool {
        ProcessInfo.processInfo.environment["networking_success"] == "1"
    }
}
#endif
