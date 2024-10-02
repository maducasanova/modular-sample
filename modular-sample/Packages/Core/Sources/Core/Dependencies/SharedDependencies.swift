//
//  SharedDependencies.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

extension DependencyValues {
    private enum CustumerIdKey: DependencyKey {
        static var defaultValue: String?
    }

    private enum UserSessionKey: DependencyKey {
        static var defaultValue: UserSession = UserSession()
    }

    public var userSession: UserSession {
        get { self[UserSessionKey.self] }
        set { self[UserSessionKey.self] = newValue }
    }

    private enum UserNameKey: DependencyKey {
        static var defaultValue: String?
    }
}
