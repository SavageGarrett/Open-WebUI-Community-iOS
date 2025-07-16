//
//  ConnectViewModel.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation
import SwiftUI

@MainActor
class ConnectViewModel: ObservableObject {
    @Published var serverAddress: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isConnected: Bool = false
    @Published var serverInfo: WebUIStatusResponse?
    
    private let configService: ConfigServiceProtocol
    
    init(configService: ConfigServiceProtocol = ConfigService.shared) {
        self.configService = configService
    }
    
    var isValidURL: Bool {
        guard let url = URL(string: serverAddress) else { return false }
        return url.scheme != nil && url.host != nil
    }
    
    func connect() {
        guard isValidURL else {
            alertMessage = "Please enter a valid URL or IP address."
            showAlert = true
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let response = try await configService.fetchConfig(serverUrl: serverAddress)
                serverInfo = response
                isConnected = true
                print("✅ Connected to \(response.name), version \(response.version)")
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
                print("❌ Failed to fetch config:", error)
            }
            
            isLoading = false
        }
    }
    
    func resetConnection() {
        isConnected = false
        serverInfo = nil
        serverAddress = ""
    }
} 