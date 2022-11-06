//
//  Companions.swift
//  Chat
//
//  Created by Дарья on 06.11.2022.
//

import Foundation

struct Companions: Codable {
    let companions: [Companion]
    
    private enum CodingKeys: String, CodingKey {
        case companions = "users"
    }
}

struct Companion: Codable {
    let id: String
    let name: String
}
