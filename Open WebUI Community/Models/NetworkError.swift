//
//  NetworkError.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case decodingFailed
    case requestFailed(Error)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL provided"
        case .decodingFailed:
            return "Failed to decode server response"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server"
        }
    }
} 