//
//  LoginService.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation

// User session storage
class UserSession: ObservableObject {
    static let shared = UserSession()
    
    @Published var loginResponse: LoginResponse?
    @Published var isLoggedIn: Bool = false
    
    private init() {}
    
    func setLoginResponse(_ response: LoginResponse) {
        loginResponse = response
        isLoggedIn = true
    }
    
    func clear() {
        loginResponse = nil
        isLoggedIn = false
    }
    
    var userToken: String? {
        return loginResponse?.token
    }
    
    var userName: String? {
        return loginResponse?.name
    }
    
    var userEmail: String? {
        return loginResponse?.email
    }
    
    var userRole: String? {
        return loginResponse?.role
    }
    
    var userPermissions: Permissions? {
        return loginResponse?.permissions
    }
}

protocol LoginServiceProtocol {
    func login(email: String, password: String, serverUrl: String) async throws -> LoginResponse
}

class LoginService: LoginServiceProtocol {
    static let shared = LoginService()
    
    private init() {}
    
    func login(email: String, password: String, serverUrl: String) async throws -> LoginResponse {
        let trimmedUrl = serverUrl.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        guard let url = URL(string: "\(trimmedUrl)/api/v1/auths/signin") else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = [
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            throw NetworkError.requestFailed(error)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            return try JSONDecoder().decode(LoginResponse.self, from: data)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
} 