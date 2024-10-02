//
//  URLSession.swift
//  Networking
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation
import Core

public class SampleAppURLSessionDelegate: NSObject, URLSessionDataDelegate { }


public class SampleAppURLSession {
    public static let shared: URLSession = {
        let instance = URLSession(
            configuration: .default,
            delegate: SampleAppURLSessionDelegate(), delegateQueue: nil
        )
        return instance
    }()
}
