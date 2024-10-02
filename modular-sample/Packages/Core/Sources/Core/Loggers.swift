//
//  Loggers.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import OSLog

public enum Log {
    private static let systemIdentifier = Bundle.main.bundleIdentifier ?? "ai.willowtree.Bestegg"

    public static let app = Logger(subsystem: systemIdentifier, category: "App Lifecycle")

    public static let auth = Logger(subsystem: systemIdentifier, category: "Authentication")

    public static let ui = Logger(subsystem: systemIdentifier, category: "User Interface")

    public static let network = Logger(subsystem: systemIdentifier, category: "Networking")

    public static let analytics = Logger(subsystem: systemIdentifier, category: "Analytics")
}
