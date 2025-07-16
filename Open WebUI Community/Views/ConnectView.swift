//
//  ConnectView.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import SwiftUI

struct ConnectView: View {
    @StateObject private var viewModel = ConnectViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Text("Enter Server Address")
                        .font(.title)
                    
                    TextField("e.g. https://192.168.0.1", text: $viewModel.serverAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .disabled(viewModel.isLoading)
                    
                    if viewModel.isConnected {
                        VStack(spacing: 10) {
                            Text("✅ Connected!")
                                .font(.headline)
                                .foregroundColor(.green)
                            
                            if let serverInfo = viewModel.serverInfo {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Server: \(serverInfo.name)")
                                    Text("Version: \(serverInfo.version)")
                                }
                                .font(.caption)
                                .foregroundColor(.secondary)
                            }
                            
                            Button("Disconnect") {
                                viewModel.resetConnection()
                            }
                            .buttonStyle(.bordered)
                        }
                    } else {
                        Button(action: viewModel.connect) {
                            HStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                }
                                Text(viewModel.isLoading ? "Connecting..." : "Connect")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.isLoading || !viewModel.isValidURL)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .padding()
            }
        }
        .preferredColorScheme(.dark)
        .alert("Connection Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    ConnectView()
} 
