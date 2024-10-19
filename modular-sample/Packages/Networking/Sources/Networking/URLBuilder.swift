//
//  URLBuilder.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation
import Core

public enum URLError: Error, Equatable {
    case invalidBaseUrl(baseUrl: String)
    case invalidUrl(url: String)
}

public protocol URLBuilder: Sendable {
    func buildUrl() throws -> URL
}

struct SampleAppURLBuilder: URLBuilder {
    let path: String

    func buildUrl() throws -> URL {
        @Config(key: .environment)
        var environment: BuildEnvironment

        guard let baseUrl = URL(string: environment.baseUrl) else {
            throw URLError.invalidBaseUrl(baseUrl: environment.baseUrl)
        }

        return baseUrl.appending(path: path)
    }
}

struct SampleAppAuthURLBuilder: URLBuilder {
    let path: String

    func buildUrl() throws -> URL {
        @Config(key: .environment)
        var environment: BuildEnvironment

        guard let authUrl = URL(string: environment.authUrl) else {
            throw URLError.invalidBaseUrl(baseUrl: environment.baseUrl)
        }

        return authUrl.appending(path: path)
    }
}

extension URLBuilder where Self == SampleAppURLBuilder {
    static func sampleApp(path: String) -> Self {
        SampleAppURLBuilder(path: path)
    }
}

extension URLBuilder where Self == SampleAppAuthURLBuilder {
    static func sampleAppAuth(path: String) -> Self {
        SampleAppAuthURLBuilder(path: path)
    }
}
