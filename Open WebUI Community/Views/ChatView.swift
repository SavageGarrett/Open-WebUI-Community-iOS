//
//  ChatView.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Main Content
                VStack {
                    // Top Bar with Menu Icon
                    HStack {
                        Button(action: {
                            viewModel.toggleDrawer()
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
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
                                Text("Hello, \(viewModel.userName)")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        // Chat Input
                        ChatInputView(messageText: $viewModel.messageText, onSend: viewModel.sendMessage)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .background(Color(.systemBackground))
                
                // Side Drawer
                SideDrawerView(
                    isOpen: $viewModel.isDrawerOpen,
                    chatHistory: $viewModel.chatHistory,
                    onNewChat: viewModel.startNewChat,
                    onSelectChat: viewModel.selectChat
                )
            }
        }
        .preferredColorScheme(.dark)
        .gesture(
            DragGesture()
                .onEnded { value in
                    viewModel.handleDrawerGesture(value.translation)
                }
        )
    }
}

// MARK: - Side Drawer Component
struct SideDrawerView: View {
    @Binding var isOpen: Bool
    @Binding var chatHistory: [ChatItem]
    let onNewChat: () -> Void
    let onSelectChat: (ChatItem) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Drawer Content
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 16) {
                        HStack {
                            Text("Chat History")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isOpen = false
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        // New Chat Button
                        Button(action: onNewChat) {
                            HStack {
                                Image(systemName: "plus")
                                    .font(.title3)
                                Text("New Chat")
                                    .font(.headline)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Chat History List
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(chatHistory) { chat in
                                ChatHistoryItemView(chat: chat) {
                                    onSelectChat(chat)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                }
                .frame(width: geometry.size.width * 0.8)
                .background(Color(.secondarySystemBackground))
                .offset(x: isOpen ? 0 : -geometry.size.width * 0.8)
                
                // Overlay
                if isOpen {
                    Color.black.opacity(0.3)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isOpen = false
                            }
                        }
                }
            }
        }
    }
}

// MARK: - Chat History Item Component
struct ChatHistoryItemView: View {
    let chat: ChatItem
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: "message")
                    .foregroundColor(.secondary)
                    .font(.system(size: 16))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(chat.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text(chat.timestamp, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.tertiarySystemBackground))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
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
