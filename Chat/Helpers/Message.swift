//
//  Message.swift
//  Chat
//
//  Created by Павел on 30.10.2022.
//

import Foundation

enum MessageType: String, Codable {
    case outcoming
    case incoming
    case system
}

struct Message: Codable {
    let type: MessageType
    let text: String
    let timestamp: Double
    let uuid: UUID
}
