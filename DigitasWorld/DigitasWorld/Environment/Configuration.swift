//
//  Configuration.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation

enum Environment: String {
    case dev = "DEV"
    case prod = "PROD"
    case qa = "QA"
}

struct Configuration {
    
    private static let environment: Environment = {
        
        guard let environmentString = Bundle.main.infoDictionary?["Environment"] as? String else {
             return .dev
        }
        return Environment(rawValue: environmentString) ?? .dev
    }()
    
    private static let environmentSettings: [String: String]? = {
        if let envPlistPath = Bundle.main.path(forResource: "EnvironmentList", ofType: "plist"),
            let envDict = NSDictionary(contentsOfFile: envPlistPath) {
            let envSettings = envDict[environment.rawValue] as? [String: String]
            return envSettings
        } else {
            assertionFailure("Environment.plist is not found!")
            return nil
        }
    }()
    
    static var getEnvironment: String {
        return environment.rawValue
    }
    
    static let baseURL: String = {
        guard let url = environmentSettings?["base-url"] else {
            assertionFailure("BaseURL is not set for environment: \(environment)!")
            return ""
        }
        return url
    }()
    
    static let apiKey: String = {
        guard let key = environmentSettings?["api-key"] else {
            assertionFailure("Api Key is not set for environment: \(environment)!")
            return ""
        }
        return key
    }()
    
    static let apiHost: String = {
        guard let host = environmentSettings?["api-host"] else {
            assertionFailure("Host is not set for environment: \(environment)!")
            return ""
        }
        return host
    }()
}
