//
//  ChatView.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var userSession = UserSession.shared
    @State private var messageText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // Centered Content
                VStack(spacing: 40) {
                    // Greeting
                    VStack(spacing: 16) {
                        // Logo and Text centered together
                        HStack(spacing: 16) {
                            // Logo
                            Image("Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .background(Color.black)
                                .clipShape(Circle())
                            
                            // Text
                            Text("Hello, \(userSession.userName ?? "User")")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    // Chat Input
                    ChatInputView(messageText: $messageText, onSend: sendMessage)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color(.systemBackground))
        }
        .preferredColorScheme(.dark)
    }
    
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        messageText = ""
    }
}

// MARK: - Input Area Component
struct ChatInputView: View {
    @Binding var messageText: String
    let onSend: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            // Text Field (First Line)
            TextField("How can I help you today?", text: $messageText)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.body)
                .foregroundColor(.primary)
            
            // Icons (Second Line)
            HStack {
                // Left side - File icons
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .foregroundColor(.secondary)
                            .font(.system(size: 16))
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "doc.text")
                            .foregroundColor(.secondary)
                            .font(.system(size: 16))
                    }
                }
                
                Spacer()
                
                // Right side - Voice and Send icons
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "mic")
                            .foregroundColor(.secondary)
                            .font(.system(size: 16))
                    }
                    
                    Button(action: onSend) {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                    }
                    .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
    }
}

#Preview {
    ChatView()
} 
