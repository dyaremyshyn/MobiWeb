//
//  StringDataLoader.swift
//  LoggingSDK
//
//  Created by Dmytro Yaremyshyn on 26/08/2024.
//

import Foundation

public protocol StringDataLoader {

    static func logString(_ string: String, completion: @escaping (Result<Void, Error>) -> Void)
}
