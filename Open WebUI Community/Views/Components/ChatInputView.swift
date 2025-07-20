//
//  ChatInputView.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import SwiftUI

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
    ChatInputView(
        messageText: .constant(""),
        onSend: {}
    )
} 