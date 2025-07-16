//
//  ChatView.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var userSession = UserSession.shared
    @StateObject private var serverConfig = ServerConfig.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // User Profile Section
                VStack(spacing: 15) {
                    // Profile Image
                    if let profileImageUrl = userSession.loginResponse?.profileImageUrl,
                       let url = URL(string: profileImageUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                    }
                    
                    // User Info
                    VStack(spacing: 8) {
                        Text(userSession.userName ?? "Unknown User")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(userSession.userEmail ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text("Role:")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(userSession.userRole ?? "Unknown")
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(4)
                        }
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                
                // Server Info
                if let serverInfo = serverConfig.serverInfo {
                    VStack(spacing: 8) {
                        Text("Connected Server")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        VStack(spacing: 4) {
                            Text(serverInfo.name)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Text("Version: \(serverInfo.version)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            if let serverURL = URL(string: serverConfig.serverURL),
                               let host = serverURL.host {
                                Text("Server: \(host)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.tertiarySystemBackground))
                    .cornerRadius(12)
                }
                
                // Permissions Section
                if let permissions = userSession.userPermissions {
                    VStack(spacing: 12) {
                        Text("Your Permissions")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            PermissionCard(title: "Chat Controls", isEnabled: permissions.chat.controls)
                            PermissionCard(title: "File Upload", isEnabled: permissions.chat.fileUpload)
                            PermissionCard(title: "System Prompt", isEnabled: permissions.chat.systemPrompt)
                            PermissionCard(title: "Web Search", isEnabled: permissions.features.webSearch)
                            PermissionCard(title: "Image Generation", isEnabled: permissions.features.imageGeneration)
                            PermissionCard(title: "Code Interpreter", isEnabled: permissions.features.codeInterpreter)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                }
                
                Spacer()
                
                // Logout Button
                Button(action: {
                    userSession.clear()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign Out")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.large)
        }
        .preferredColorScheme(.dark)
    }
}

struct PermissionCard: View {
    let title: String
    let isEnabled: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isEnabled ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isEnabled ? .green : .red)
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.tertiarySystemBackground))
        .cornerRadius(8)
    }
}

#Preview {
    ChatView()
} 