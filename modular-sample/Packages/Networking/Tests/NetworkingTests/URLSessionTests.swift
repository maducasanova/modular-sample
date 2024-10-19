//
//  URLSessionTests.swift
//  Networking
//
//  Created by Maria Casanova on 10/18/24.
//

import XCTest
@testable import Networking

final class URLSessionTests: XCTestCase {

    // swiftlint:disable force_cast
    func testValidationFailsWhenResponseIsNotHTTPURLResponse() {
        let response = URLResponse()
        let request = URLRequest(url: URL(string: "https://mock-url.com")!)

        XCTAssertThrowsError(try URLSession.validateResponse(for: request, payload: (Data(), response), shouldLog: false)) { error in
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse(response))
        }
    }
    // swiftlint:enable force_cast

    func testValidationFailsWhenResponseStatusIsInvalid() {
        let data = Data()
        let request = URLRequest(url: URL(string: "https://mock-url.com")!)
        let invalidResponses = [107, 300, 404, 500]
            .compactMap { HTTPURLResponse(url: .test, statusCode: $0, httpVersion: nil, headerFields: nil)}

        for invalidResponse in invalidResponses {
            XCTAssertThrowsError(try URLSession.validateResponse(for: request, payload: (data, invalidResponse), shouldLog: false)) { error in
                XCTAssertTrue(error is NetworkError)
            }
        }
    }

    func testValidationSuccedsWhenResponseStatusIsValid() throws {
        let data = Data()
        let request = URLRequest(url: URL(string: "https://mock-url.com")!)
        let invalidResponses = [200, 299]
            .compactMap { HTTPURLResponse(url: .test, statusCode: $0, httpVersion: nil, headerFields: nil)}

        for response in invalidResponses {
            let actualData = try URLSession.validateResponse(for: request, payload: (data, response), shouldLog: false)
            XCTAssertEqual(actualData, data)
        }
    }

    // swiftlint:disable force_cast
    func testValidationSuccedsWhenIsErrorRespnse() throws {
        let data = Data(
        """
        {
          "message": "Bad Request",
          "code": "Code",
        }
        """.utf8
        )
        let responses = [400]
            .compactMap { HTTPURLResponse(url: .test, statusCode: $0, httpVersion: nil, headerFields: nil)}
        let request = URLRequest(url: URL(string: "https://mock-url.com")!)

        for response in responses {
            XCTAssertThrowsError(try URLSession.validateResponse(for: request, payload: (data, response), shouldLog: false)) { error in
                XCTAssertTrue(error is NetworkError)
            }
        }
    }
    // swiftlint:enable force_cast
}
