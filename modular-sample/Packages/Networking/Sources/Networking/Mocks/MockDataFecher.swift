//
//  MockDataFecher.swift
//  Networking
//
//  Created by Maria Casanova on 10/18/24.
//

import Foundation

// MARK: MockDataFetcher
#if DEBUG
struct MockDataFetcher: DataFetcher {
    let dataResponse: @Sendable () async throws -> Data

    func fetch(for request: URLRequest) async throws -> Data {
        try await dataResponse()
    }
}
#endif
