//
//  ChatHistoryItemView.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import SwiftUI

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

#Preview {
    ChatHistoryItemView(
        chat: ChatItem(id: UUID(), title: "Sample Chat", timestamp: Date()),
        onTap: {}
    )
} 