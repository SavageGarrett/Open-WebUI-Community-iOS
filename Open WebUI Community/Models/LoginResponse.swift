//
//  LoginResponse.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation

struct LoginResponse: Codable {
    let id: String
    let email: String
    let name: String
    let role: String
    let profileImageUrl: String?
    let token: String
    let tokenType: String
    let expiresAt: String?
    let permissions: Permissions
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case role
        case profileImageUrl = "profile_image_url"
        case token
        case tokenType = "token_type"
        case expiresAt = "expires_at"
        case permissions
    }
}

struct Permissions: Codable {
    let workspace: WorkspacePermissions
    let sharing: SharingPermissions
    let chat: ChatPermissions
    let features: FeaturePermissions
}

struct WorkspacePermissions: Codable {
    let models: Bool
    let knowledge: Bool
    let prompts: Bool
    let tools: Bool
}

struct SharingPermissions: Codable {
    let publicModels: Bool
    let publicKnowledge: Bool
    let publicPrompts: Bool
    let publicTools: Bool
    
    enum CodingKeys: String, CodingKey {
        case publicModels = "public_models"
        case publicKnowledge = "public_knowledge"
        case publicPrompts = "public_prompts"
        case publicTools = "public_tools"
    }
}

struct ChatPermissions: Codable {
    let controls: Bool
    let systemPrompt: Bool
    let fileUpload: Bool
    let delete: Bool
    let edit: Bool
    let share: Bool
    let export: Bool
    let stt: Bool
    let tts: Bool
    let call: Bool
    let multipleModels: Bool
    let temporary: Bool
    let temporaryEnforced: Bool
    
    enum CodingKeys: String, CodingKey {
        case controls
        case systemPrompt = "system_prompt"
        case fileUpload = "file_upload"
        case delete
        case edit
        case share
        case export
        case stt
        case tts
        case call
        case multipleModels = "multiple_models"
        case temporary
        case temporaryEnforced = "temporary_enforced"
    }
}

struct FeaturePermissions: Codable {
    let directToolServers: Bool
    let webSearch: Bool
    let imageGeneration: Bool
    let codeInterpreter: Bool
    let notes: Bool
    
    enum CodingKeys: String, CodingKey {
        case directToolServers = "direct_tool_servers"
        case webSearch = "web_search"
        case imageGeneration = "image_generation"
        case codeInterpreter = "code_interpreter"
        case notes
    }
} 