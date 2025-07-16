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
        NavigationStack {
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
                    
                    Button(action: viewModel.connect) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .foregroundColor(.white)
                            }
                            Text(viewModel.isLoading ? "Connecting..." : "Connect")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(viewModel.isLoading || !viewModel.isValidURL)
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .padding()
            }
            .navigationDestination(isPresented: $viewModel.shouldNavigateToLogin) {
                LoginView()
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
