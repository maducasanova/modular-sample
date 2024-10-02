//
//  HTTPMethod.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

public enum HTTPMethod: Sendable {
    public enum Payload: Sendable {
        case query([URLQueryItem])
        case body(Data)
    }

    case get([Payload]? = nil)
    case put([Payload]? = nil)
    case post([Payload]? = nil)
    case delete([Payload]? = nil)

    var name: String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }

    var payload: [Payload]? {
        switch self {
        case    .get(let payloads),
                .put(let payloads),
                .post(let payloads),
                .delete(let payloads):
            return payloads
        }
    }
}
