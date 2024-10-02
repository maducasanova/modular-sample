//
//  URLSession+.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Core
import Foundation

extension URLSession: DataFetcher {
    public func fetch(for request: URLRequest) async throws -> Data {
        let payload: (Data, URLResponse) = try await data(for: request)

        return try URLSession.validateResponse(for: request, payload: payload)
    }

    static func validateResponse(
        for request: URLRequest,
        payload: (Data, URLResponse),
        shouldLog: Bool = true
    ) throws -> Data {
        let (data, response) = payload

        #if DEBUG
        if shouldLog {
            debugLog(for: request, payload: payload)
        }
        #endif

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidResponse(response)
        }

        guard (200 ..< 300).contains(statusCode) else {
            if statusCode == 401 {
                throw NetworkError.unauthorized
            } else {
                throw NetworkError.invalidError(response, statusCode)
            }
        }

        return data
    }

    static func debugLog(for request: URLRequest, payload: (data: Data, response: URLResponse)) {
        let response = payload.response as? HTTPURLResponse
        let data = payload.data

        let url = response?.url?.absoluteString ?? "UNKNOWN URL"
        let statusCode = response?.statusCode ?? .zero
        let type = request.httpMethod ?? "UNKNOWN TYPE"

        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])

        var stringValue: String?

        if let jsonObject = jsonObject, let mappedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
            stringValue = String(data: mappedData, encoding: .utf8) ?? "could not parse to json"
        }

        Log.network.debug(
            """
            [Request Logger]
            REQUEST: "\(url)"
            TYPE: "\(type)"
            CODE: "\(statusCode)"

            RESPONSE: "\(stringValue ?? "could not parse to json")"
            """
        )
    }
}
