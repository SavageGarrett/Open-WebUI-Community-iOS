//
//  URLValidator.swift
//  Open WebUI Community
//
//  Created by Garrett Carder on 7/14/25.
//

import Foundation

struct URLValidator {
    static func isValidURL(_ string: String) -> Bool {
        guard let url = URL(string: string) else { return false }
        return url.scheme != nil && url.host != nil
    }
    
    static func normalizeURL(_ string: String) -> String {
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
} 