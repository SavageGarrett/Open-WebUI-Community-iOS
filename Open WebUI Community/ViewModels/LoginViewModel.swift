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
        
        isLoading = true
        showAlert = false
        
        // Simulate login API call
        Task {
            do {
                try await Task.sleep(nanoseconds: 2_000_000_000) // 2 second delay
                
                // TODO: Implement actual login API call here
                // For now, we'll simulate a successful login
                print("✅ Login successful for \(email)")
                
                // Navigate to main app or show success
                // This will be handled by the parent view
                
            } catch {
                alertMessage = "Login failed. Please try again."
                showAlert = true
                print("❌ Login failed:", error)
            }
            
            isLoading = false
        }
    }
} 