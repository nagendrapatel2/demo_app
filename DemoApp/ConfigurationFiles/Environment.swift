//
//  Environment.swift
//  DemoApp
//
//  Created by Nagendra on 01/09/23.
//

import Foundation

public enum AppEnvironment {
    case dev, uat, production

    /// Get current environment based on configuration set
    static var current: Self {
        #if TEST
        return .uat
        #elseif PROD
        return .production
        #else
        return .dev
        #endif
    }

    /// The consistent part or root of each webservice address.
    static let baseURL: String = {
        value(forKey: .rootURL)
    }()
}

// MARK: - Configuration file keys
extension AppEnvironment {
    /// Custom keys used to retrieve environment configuration values from Info.plist
    enum Keys: String {
        case rootURL = "ROOT_URL"
    }
}

extension AppEnvironment {

    private static let infoDictionary: [String: Any] = {
        guard let infoDict = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found!")
        }
        return infoDict
    }()

    private static func value(forKey key: AppEnvironment.Keys) -> String {
        guard let stringValue = AppEnvironment.infoDictionary[key.rawValue] as? String else {
            fatalError("\(key.rawValue) not set in Info.plist for \(AppEnvironment.current.description) environment.")
        }

        return stringValue
    }
}

extension AppEnvironment: CustomStringConvertible {
    public var description: String {
        switch self {
        case .dev: return "Development"
        case .uat: return "Testing"
        case .production: return "Production"
        }
    }
}
