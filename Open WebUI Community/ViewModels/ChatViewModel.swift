//
//  ChatViewModel.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation
import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messageText: String = ""
    @Published var isDrawerOpen: Bool = false
    @Published var chatHistory: [ChatItem] = []
    
    let userSession = UserSession.shared
    
    init() {
        loadInitialChatHistory()
    }
    
    var isMessageValid: Bool {
        !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var userName: String {
        userSession.userName ?? "User"
    }
    
    // MARK: - Chat Management
    
    func sendMessage() {
        guard isMessageValid else { return }
        
        // TODO: Implement actual message sending logic
        // For now, just clear the message text
        messageText = ""
    }
    
    func startNewChat() {
        let newChat = ChatItem(id: UUID(), title: "New Chat", timestamp: Date())
        chatHistory.insert(newChat, at: 0)
        closeDrawer()
    }
    
    func selectChat(_ chat: ChatItem) {
        // TODO: Implement chat selection logic
        print("Selected chat: \(chat.title)")
        closeDrawer()
    }
    
    // MARK: - Drawer Management
    
    func toggleDrawer() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isDrawerOpen.toggle()
        }
    }
    
    func openDrawer() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isDrawerOpen = true
        }
    }
    
    func closeDrawer() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isDrawerOpen = false
        }
    }
    
    func handleDrawerGesture(_ translation: CGSize) {
        if translation.width > 100 && !isDrawerOpen {
            openDrawer()
        } else if translation.width < -100 && isDrawerOpen {
            closeDrawer()
        }
    }
    
    // MARK: - Private Methods
    
    private func loadInitialChatHistory() {
        chatHistory = [
            ChatItem(id: UUID(), title: "Previous Chat 1", timestamp: Date()),
            ChatItem(id: UUID(), title: "Previous Chat 2", timestamp: Date().addingTimeInterval(-3600)),
            ChatItem(id: UUID(), title: "Previous Chat 3", timestamp: Date().addingTimeInterval(-7200))
        ]
    }
}

// MARK: - Chat Item Model
struct ChatItem: Identifiable {
    let id: UUID
    let title: String
    let timestamp: Date
} 