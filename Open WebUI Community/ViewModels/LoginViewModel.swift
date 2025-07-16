//
//  LoginViewModel.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    let serverConfig = ServerConfig.shared
    let userSession = UserSession.shared
    private let loginService = LoginService.shared
    
    var isValidForm: Bool {
        !email.isEmpty && !password.isEmpty && isValidEmail(email)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func login() {
        guard isValidForm else {
            alertMessage = "Please enter a valid email and password."
            showAlert = true
            return
        }
        
        guard !serverConfig.serverURL.isEmpty else {
            alertMessage = "No server URL found. Please go back and connect to a server first."
            showAlert = true
            return
        }
        
        isLoading = true
        showAlert = false
        
        Task {
            do {
                let response = try await loginService.login(
                    email: email,
                    password: password,
                    serverUrl: serverConfig.serverURL
                )
                
                userSession.setLoginResponse(response)
                print("✅ Login successful for \(response.email) on server: \(serverConfig.serverURL)")
                print("User: \(response.name) (\(response.role))")
                print("Token: \(response.token)")
                
                // Navigate to main app or show success
                // This will be handled by the parent view
                
            } catch {
                alertMessage = "Login failed. Please check your credentials and try again."
                showAlert = true
                print("❌ Login failed:", error)
            }
            
            isLoading = false
        }
    }
} 