//
//  NetworkClient.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Core
import UIKit

public struct NetworkClient: Sendable {
    @Dependency(\.userSession) private var userSession

    private var dataFetcher: DataFetcher

    public init(dataFetcher: DataFetcher = SampleAppURLSession.shared) {
        self.dataFetcher = dataFetcher
    }

    private func response<Response>(
        for endpoint: Endpoint,
        transform: (Data) throws -> Response
    ) async throws -> Response {
        let request = try await endpoint.request()
        let data = try await dataFetcher.fetch(for: request)
        return try transform(data)
    }

    public func response(for endpoint: Endpoint?) async throws {
        guard let endpoint = endpoint else { throw NetworkError.endpointError }
        try await response(for: endpoint) { _ in }
    }

    public func responseAsData(for endpoint: Endpoint?) async throws -> Data {
        guard let endpoint = endpoint else { throw NetworkError.endpointError }
        return try await response(for: endpoint) { data in
            return data
        }
    }

    public func response<Response>(
        for endpoint: Endpoint?
    ) async throws -> Response where Response: Decodable {
        guard let endpoint = endpoint else { throw NetworkError.endpointError }
        return try await response(for: endpoint) { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategyFormatters = [ DateFormatter.standardT,
                                                       DateFormatter.standard,
                                                       DateFormatter.yearMonthDay ]
            return try decoder.decode(Response.self, from: data)
        }
    }

    public func image(
        for endpoint: Endpoint
    ) async throws -> UIImage {
        struct InvalidImageData: Error {
            let data: Data
        }

        return try await response(for: endpoint) { data in
            guard let image = UIImage(data: data) else {
                throw InvalidImageData(data: data)
            }

            return image
        }
    }
}
