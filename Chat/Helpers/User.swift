//
//  User.swift
//  User
//
//  Created by Павел on 29.10.2022.
//

import Foundation

struct User: Codable {
    let uuid: UUID
    let name: String
    let email: String
}
