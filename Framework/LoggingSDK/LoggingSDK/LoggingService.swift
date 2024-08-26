//
//  LoggingService.swift
//  LoggingSDK
//
//  Created by Dmytro Yaremyshyn on 26/08/2024.
//

import Foundation

// Class responsible for recording logs on a remote server.
public class LoggingService: StringDataLoader {
    
    /// Sends a string to the server for logging purposes.
    /// - Parameters:
    /// - string: The string that should be registered.
    /// - completion: Callback that is called when the operation is completed.
    /// - Success: Indicates that the operation was successful.
    /// - Failure: Returns an error if it occurs.
    public static func logString(_ string: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Endpoint URL
        let url = URL(string: "https://us-central1-mobilesdklogging.cloudfunctions.net/saveString")!
        
        // Request configuration
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Body
        let body: [String: String] = ["myString": string]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        // Making the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
}
