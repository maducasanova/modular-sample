//
//  NetworkClientTests.swift
//  Networking
//
//  Created by Maria Casanova on 10/18/24.
//

import XCTest
@testable import Networking

final class NetworkClientTest: XCTestCase {
    struct Fixture: Decodable, Equatable {
        let something: String
    }

    enum TestError: Error, Decodable {
        case fetchError
    }

    func testNetworkClientDecodesResponse() async throws {
        let mockDataFetcher = MockDataFetcher {
            try XCTUnwrap(
                #"{"something": "Something"}"#
                    .data(using: .utf8)
            )
        }

        let networkClient = NetworkClient(dataFetcher: mockDataFetcher)
        let expected = Fixture(something: "Something")
        let actual: Fixture = try await networkClient.response(for: .test)
        XCTAssertEqual(actual, expected)
    }

    func testNetworkClientDecodesFails() async throws {
        let mockDataFetcher = MockDataFetcher {
            try XCTUnwrap(
                #"{"value": "Something"}"#
                    .data(using: .utf8)
            )
        }

        let networkClient = NetworkClient(dataFetcher: mockDataFetcher)
        await XCTAssertAsyncThrowError( try await networkClient.response(for: .test) as Fixture)
    }

    // swiftlint:disable force_cast
    func testNetworkClientRetrowsDataFetcherError() async throws {
        let mockDataFetcher = MockDataFetcher {
            throw TestError.fetchError
        }

        let networkClient = NetworkClient(dataFetcher: mockDataFetcher)
        await XCTAssertAsyncThrowError( try await networkClient.response(for: .test) as Fixture) { error in
            XCTAssertTrue(error is TestError)
            XCTAssertEqual(error as! TestError, TestError.fetchError)
        }
    }
    // swiftlint:enable force_cast
}
