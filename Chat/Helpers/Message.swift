//
//  Message.swift
//  Chat
//
//  Created by Дарья on 02.11.2022.
//

import Foundation

struct Message: Codable {
    let type: String
    let text: String
    let timestamp: Double
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case type, text, timestamp
    }
}
