//
//  Sequence+.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

public extension Collection {
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
