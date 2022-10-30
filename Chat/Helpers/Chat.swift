//
//  User.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import Foundation

struct Chat: Codable {
    let uuid: UUID
    let companions: [User]
    let lastMessage: LastMessage?
    let chatLogo: URL?

    private enum CodingKeys: String, CodingKey {
        case uuid = "id"
        case companions
        case chatLogo = "chat_logo"
        case lastMessage = "last_message"
    }
    
}

struct ChatListResult: Codable {
    let chatList: [Chat]
    
    private enum CodingKeys: String, CodingKey {
        case chatList = "chat_list"
    }
}
 
