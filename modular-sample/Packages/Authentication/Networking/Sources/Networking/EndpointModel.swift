//
//  EndpointModel.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

// A model that represents an API andpoint
public struct Endpoint: Sendable {
    /// The object for building an endpoint's URL
    public let urlBuilder: any URLBuilder
    /// The object responsible for assembling  the request headers
    public let headerPolicy: any HeaderPolicy
    /// The HTTP method to use for the request
    public let method: HTTPMethod

    public init(urlBuilder: any URLBuilder, headerPolicy: any HeaderPolicy, method: HTTPMethod) {
        self.urlBuilder = urlBuilder
        self.headerPolicy = headerPolicy
        self.method = method
    }

    /// The URL request for this endpoint
    func request() async throws -> URLRequest {
        let url = try urlBuilder.buildUrl()
        let headers = try await headerPolicy.generateHeaders()
        var request = URLRequest(url: url)
        request.httpMethod = method.name

        method.payload?.forEach { payload in
            switch payload {
            case .body(let data):
                request.httpBody = data
            case .query(let items):
                request.addQuery(items)
            }
        }

        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }

        return request
    }
}

private extension URLRequest {
    mutating func addQuery(_ queryItems: [URLQueryItem]) {
        guard let url, !queryItems.isEmpty else { return }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        if let existingQueryItems = components?.queryItems {
            components?.queryItems = existingQueryItems + queryItems
        } else {
            components?.queryItems = queryItems
        }

        guard let updateUrl = components?.url else {
            preconditionFailure("Couldn't create url from components")
        }

        self.url = updateUrl
    }
}
