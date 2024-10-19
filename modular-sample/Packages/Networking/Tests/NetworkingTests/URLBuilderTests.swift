//
//  URLBuilderTests.swift
//  Networking
//
//  Created by Maria Casanova on 10/18/24.
//

import XCTest
import Core
@testable import Networking

final class URLBuilderTests: XCTestCase {
    override func setUp() {
        InfoConfiguration.mockConfiguration()
    }

    func testBesteggURLBuilder() throws {
        let builder: URLBuilder = .sampleApp(path: "test/path")
        let url = try builder.buildUrl()
        XCTAssertEqual(url, URL(string: "https://api.debug.com/test/path"))
    }

    func testBesteggAuthURLBuilder() throws {
        let builder: URLBuilder = .sampleAppAuth(path: "auth/path")
        let url = try builder.buildUrl()
        XCTAssertEqual(url, URL(string: "https://auth.sbx.com/auth/path"))
    }
}
