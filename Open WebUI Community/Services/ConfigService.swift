//
//  ConfigService.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation

protocol ConfigServiceProtocol {
    func fetchConfig(serverUrl: String) async throws -> WebUIStatusResponse
}

class ConfigService: ConfigServiceProtocol {
    static let shared = ConfigService()
    
    private init() {}
    
    func fetchConfig(serverUrl: String) async throws -> WebUIStatusResponse {
        let trimmedUrl = serverUrl.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        guard let url = URL(string: "\(trimmedUrl)/api/config") else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            return try JSONDecoder().decode(WebUIStatusResponse.self, from: data)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
} 