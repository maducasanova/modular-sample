//
//  DependencyKeys.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

public protocol DependencyKey {
    associatedtype Value
    static var defaultValue: Value { get }
}
