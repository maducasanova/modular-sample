//
//  Config.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

public enum InfoConfiguration {
    public typealias Info = [String: Any]
    public typealias InfoProvider = () -> Info

    private(set) static var provideInfo: InfoProvider = { [:] }

    public static func configure(with provider: @autoclosure @escaping InfoProvider) {
        Self.provideInfo = provider
    }

    public static func add(info: [String: Any]) {
        let currentInfo = provideInfo()
        let mergedContent = currentInfo.merging(info) { (_, new) in new }
        Self.provideInfo = { mergedContent }
    }
}

@propertyWrapper
public struct Config<Value: LosslessStringConvertible> {
    public enum Key: String {
        case environment = "ENVIRONMENT"
    }

    var key: Key

    public var wrappedValue: Value {
        Self.value(for: key)
    }

    public init(key: Key) {
        self.key = key
    }

    private static func value(for key: Key) -> Value {
        let info = InfoConfiguration.provideInfo()

        guard let rawValue = info[key.rawValue] as? String else {
            fatalError("Missing Info.plist value for key: \(key.rawValue)")
        }

        guard let value = Value(rawValue) else {
            fatalError("Invalid configuration value for key \(key.rawValue)")
        }

        return value
    }
}

public enum BuildEnvironment: String, LosslessStringConvertible, CaseIterable {
    case mock
    case debug
    case uat
    case production

    public init?(_ description: String) {
        self.init(rawValue: description.lowercased())
    }

    public var baseUrl: String {
        switch self {
        case .mock:
            return "http://localhost:8080/"
        case .debug:
            return "https://api.debug.com/"
        case .uat:
            return "https://api.uat.com/"
        case .production:
            return "https://api.com/"

        }
    }

    public var authUrl: String {
        switch self {
        case .mock:
            return "http://localhost:8080/"
        case .debug:
            return "https://auth.sbx.com/"
        case .uat:
            return "https://auth.uat.com/"
        case .production:
            return "https://auth.com/"

        }
    }

    public var description: String { rawValue }
}
