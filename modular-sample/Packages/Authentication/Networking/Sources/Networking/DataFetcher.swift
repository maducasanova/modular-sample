//
//  DataFetcher.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

public protocol DataFetcher: Sendable {
    @discardableResult
    func fetch(for request: URLRequest) async throws -> Data
}
