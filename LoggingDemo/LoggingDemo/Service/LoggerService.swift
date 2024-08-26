//
//  LoggerService.swift
//  LoggingDemo
//
//  Created by Dmytro Yaremyshyn on 26/08/2024.
//

import Foundation
import LoggingSDK

public struct LoggerService {
    
    public func logString(string: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        LoggingService.logString(string, completion: completion)
    }
}
