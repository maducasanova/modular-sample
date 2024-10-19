//
//  XCTests+Async.swift
//  Networking
//
//  Created by Maria Casanova on 10/18/24.
//

import XCTest

extension XCTest {
    public func XCTAssertAsyncThrowError<T: Sendable>(
        _ expression: @Sendable @autoclosure () async throws -> T,
        _ messsage: @Sendable @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: @Sendable (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
                XCTFail(messsage(), file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}

extension XCTestCase {
    public func XCTAssertNilAsync<T>(
        _ expression: @autoclosure () async throws -> T?,
        timeout: TimeInterval = 1,
        file: StaticString = #filePath,
        line: UInt = #line
    ) async throws {
        do {
            let result = try await expression()
            XCTAssertNil(result, "Expression was not nil", file: file, line: line)
        } catch {
            XCTFail("Expression threw an error \(error)", file: file, line: line)
        }
    }
}
