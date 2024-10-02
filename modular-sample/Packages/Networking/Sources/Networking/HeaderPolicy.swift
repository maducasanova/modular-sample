//
//  HeaderPolicy.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation
import Core

public enum APIHeaderKey: String {
    case accept = "accept"
    case authSession = "auth-session-id"
    case authorization = "Authorization"
    case contentType = "Content-Type"
}

public protocol HeaderPolicy: Sendable {
    func generateHeaders() async throws -> [String: String]
}

struct EmptyHeaderPolicy: HeaderPolicy {
    func generateHeaders() throws -> [String: String] { [:] }
}

struct PrimaryPolicy: HeaderPolicy {
    func generateHeaders() throws -> [String: String] {
        let headers = [
            APIHeaderKey.accept.rawValue: "*/*",
            APIHeaderKey.authSession.rawValue: "test"
        ]

        return headers
    }
}

struct AuthorizationPolicy: HeaderPolicy {
    @Dependency(\.userSession) private var userSession

    func generateHeaders() async throws -> [String: String] {
        var headers: [String: String] = [:]

        if let token = await userSession.accessToken {
            headers[APIHeaderKey.authorization.rawValue] = "Bearer \(token)"
        }

        return headers
    }
}

struct ContentTypePolicy: HeaderPolicy {
    enum ContentType: String {
        case json = "application/json"
    }

    let contentType: ContentType

    func generateHeaders() throws -> [String: String] {
        [
            APIHeaderKey.contentType.rawValue: contentType.rawValue
        ]
    }
}

struct CombinedHeaderPolicy: HeaderPolicy {
    let policies: [any HeaderPolicy]

    func generateHeaders() async throws -> [String: String] {
        return try await policies
            .asyncMap { try await $0.generateHeaders() }
            .reduce(into: Dictionary()) { currentHeaders, newHeaders in
                currentHeaders.merge(newHeaders) { _, newValue in
                    newValue
                }
            }
    }
}

extension HeaderPolicy where Self == EmptyHeaderPolicy {
    static var empty: Self { .init() }
}

extension HeaderPolicy where Self == PrimaryPolicy {
    static var primary: Self {
        PrimaryPolicy()
    }
}

extension HeaderPolicy where Self == AuthorizationPolicy {
    static var auth: Self {
        AuthorizationPolicy()
    }
}

extension HeaderPolicy where Self == ContentTypePolicy {
    static func contentType(_ contentType: ContentTypePolicy.ContentType) -> Self {
        ContentTypePolicy(contentType: contentType)
    }
}

extension HeaderPolicy where Self == CombinedHeaderPolicy {
    static func combined(_ policies: (any HeaderPolicy)...) -> Self {
        CombinedHeaderPolicy(policies: policies)
    }

    static var bestEgg: Self {
        combined(.contentType(.json), .primary, .auth)
    }

    static var authenticate: Self {
        combined(.contentType(.json), .primary)
    }
}
