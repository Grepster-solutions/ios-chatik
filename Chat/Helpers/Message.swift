//
//  Message.swift
//  Chat
//
//  Created by Павел on 30.10.2022.
//

import Foundation

enum MessageContentType {
    case text
    case photo
    case video
    case audio
}

enum MessageType: String, Codable {
    case outcoming
    case incoming
    case system
}

struct Message: Codable {
    let text: String
    let timestamp: Double
    let uuid: UUID
    let author: User?
}

struct ChatOnAddMessage: Codable {
    let message: Message
}
