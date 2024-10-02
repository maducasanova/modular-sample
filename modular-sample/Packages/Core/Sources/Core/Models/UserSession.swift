//
//  UserSession.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

public actor UserSession {
    public var accessToken: String?

    public init() {}

    public init(accessToken: String) {
        self.accessToken = accessToken
    }

    public func updateAccssToken(with newValue: String? ) {
        accessToken = newValue
    }
}
