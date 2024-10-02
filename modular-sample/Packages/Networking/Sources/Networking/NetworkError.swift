//
//  NetworkError.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case invalidResponse(URLResponse)
    case invalidError(URLResponse, Int)
    case endpointError
    case unauthorized
}
