//
//  DependencyValues.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

public struct DependencyValues {
    private var dependencies = [ObjectIdentifier: any Sendable]()

    public subscript<Key: DependencyKey>(key: Key.Type) -> Key.Value {
        get {
            dependencies[ObjectIdentifier(key)] as? Key.Value ?? key.defaultValue
        }
        set {
            dependencies[ObjectIdentifier(key)] = newValue
        }
    }
}
