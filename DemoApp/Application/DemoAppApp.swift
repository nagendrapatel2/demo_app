//
//  DemoAppApp.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import SwiftUI

@main
struct DemoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}

class AppDelegate : UIResponder,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        print("UITesting Running ---------------------\(UITestingHelper.isUITesting)")
        #endif
        return true
        
    }
}
