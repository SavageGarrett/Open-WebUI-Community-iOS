//
//  SideDrawerView.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import SwiftUI

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

#Preview {
    SideDrawerView(
        isOpen: .constant(true),
        chatHistory: .constant([]),
        onNewChat: {},
        onSelectChat: { _ in }
    )
} 