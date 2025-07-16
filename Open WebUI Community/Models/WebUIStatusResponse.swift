//
//  WebUIStatusResponse.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation

struct WebUIStatusResponse: Codable {
    let status: Bool
    let name: String
    let version: String
    let defaultLocale: String
    let oauth: OAuth
    let features: Features

    enum CodingKeys: String, CodingKey {
        case status
        case name
        case version
        case defaultLocale = "default_locale"
        case oauth
        case features
    }
}

struct OAuth: Codable {
    let providers: [String: String] // empty object, flexible key-value
}

struct Features: Codable {
    let auth: Bool
    let authTrustedHeader: Bool
    let enableLdap: Bool
    let enableApiKey: Bool
    let enableSignup: Bool
    let enableLoginForm: Bool
    let enableWebsocket: Bool

    enum CodingKeys: String, CodingKey {
        case auth
        case authTrustedHeader = "auth_trusted_header"
        case enableLdap = "enable_ldap"
        case enableApiKey = "enable_api_key"
        case enableSignup = "enable_signup"
        case enableLoginForm = "enable_login_form"
        case enableWebsocket = "enable_websocket"
    }
} 