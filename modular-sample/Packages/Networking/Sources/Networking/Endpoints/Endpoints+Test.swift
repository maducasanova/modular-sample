//
//  Endpoints+Test.swift
//  Networking
//
//  Created by Maria Casanova on 10/18/24.
//

import Foundation

extension Endpoint {
    public static var test: Self {
        .init(
            urlBuilder: MockUrlBuiler(url: .test),
            headerPolicy: MockHeaderPolicy(headers: [:]),
            method: .get()
        )
    }
}

extension URL {
    public static var test: Self {
        return URL(string: "www.example.com")!
    }
}

struct MockUrlBuiler: URLBuilder {
    let url: URL

    func buildUrl() throws -> URL {
        url
    }
}

struct MockHeaderPolicy: HeaderPolicy {
    let headers: [String: String]

    func generateHeaders() throws -> [String: String] {
        headers
    }
}
