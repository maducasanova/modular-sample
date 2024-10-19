//
//  MockInfoConfigurantion.swift
//  Networking
//
//  Created by Maria Casanova on 10/18/24.
//

import Core

#if DEBUG
extension InfoConfiguration {
    public static func mockConfiguration(for environment: BuildEnvironment = .debug) {
        Self.configure(with: [
            "ENVIRONMENT": environment.rawValue
        ])
    }
}
#endif
