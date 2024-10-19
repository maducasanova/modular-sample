//
//  HeaderPolicyTest.swift
//  Networking
//
//  Created by Maria Casanova on 10/18/24.
//

import XCTest
@testable import Networking
import Core

final class HeaderPolicyTest: XCTestCase {
    @Dependency(\.userSession) var userSession

    override func setUp() {
        InfoConfiguration.mockConfiguration()
    }

    override func tearDown() {
        Task {
            await userSession.updateAccssToken(with: nil)
        }
    }

    func testContentTypeHeaderPolicy() async throws {
        let policy: HeaderPolicy = .contentType(.json)
        let headers = try await policy.generateHeaders()

        XCTAssertEqual(headers, [
            "Content-Type": "application/json"
        ])
    }

    func testPrimaryPolicy() async throws {
        let policy: HeaderPolicy = .primary
        let headers = try await policy.generateHeaders()

        XCTAssertEqual(headers, [
            "accept": "*/*",
            "auth-session-id": "test"
        ])
    }

    func testAuthWithToken() async throws {
        userSession = .init(
            accessToken: "auth-token"
        )

        let policy: HeaderPolicy = .auth
        let headers = try await policy.generateHeaders()

        XCTAssertEqual(headers, [
            "Authorization": "Bearer auth-token"
        ])
    }

    func testBestEggApi() async throws {
        @Dependency(\.userSession) var userSession
        userSession = .init(
            accessToken: "auth-token"
        )

        let policy: HeaderPolicy = .sampleApp
        let headers = try await policy.generateHeaders()

        XCTAssertEqual(headers, [
            "Content-Type": "application/json",
            "accept": "*/*",
            "auth-session-id": "test",
            "Authorization": "Bearer auth-token"
        ])
    }

    func testCombinedHeaderPoliciesMethod() async throws {
        let combinedPolicies: HeaderPolicy  = .combined(FixtureAHeaderPolicy(), FixtureBHeaderPolicy())
        let headers = try await combinedPolicies.generateHeaders()

        XCTAssertEqual(headers, [
            "fixture-A-key": "fixture-A-value",
            "fixture-B-key1": "fixture-B-value1",
            "fixture-B-key2": "fixture-B-value2"
        ])
    }
}

private extension HeaderPolicyTest {
    struct FixtureAHeaderPolicy: HeaderPolicy {
        func generateHeaders() throws -> [String: String] {
            ["fixture-A-key": "fixture-A-value"]
        }
    }

    struct FixtureBHeaderPolicy: HeaderPolicy {
        func generateHeaders() throws -> [String: String] {
            [
                "fixture-B-key1": "fixture-B-value1",
                "fixture-B-key2": "fixture-B-value2"
            ]
        }
    }
}
