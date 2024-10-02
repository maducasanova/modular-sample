//
//  DependencyContainer.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

final class DependencyContainer {
    static var shared = DependencyContainer()

    var values = DependencyValues()
}
