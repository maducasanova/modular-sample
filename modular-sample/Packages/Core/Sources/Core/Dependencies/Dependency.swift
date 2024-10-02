//
//  Dependency.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

@propertyWrapper
public struct Dependency<Value> {
    private let keyPath: WritableKeyPath<DependencyValues, Value>

    public init(_ keyPath: WritableKeyPath<DependencyValues, Value>) {
        self.keyPath = keyPath
    }

    public var wrappedValue: Value {
        get {
            DependencyContainer.shared.values[keyPath: keyPath]
        }
        nonmutating set {
            DependencyContainer.shared.values[keyPath: keyPath] = newValue
        }
    }
}

// Unchecked because KeyPath is not Sendable: https://github.com/apple/swift/issues/57560
extension Dependency: @unchecked Sendable where Value: Sendable {}
