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

#Preview {
    ChatView()
} 
