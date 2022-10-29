//
//  User.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import Foundation

struct Chat {
    
    struct LastMessage {
        let message: String
        let isMy: Bool
//        let time: Int
    }
    
    let companion: User
    let lastMessage: LastMessage?
    let chatLogo: URL?
}

extension Chat {
    static var mock = [
        Chat(companion: User(uuid: UUID(),
                             name: "Pavel",
                             email: "smka@mail.ru",
                             phone: "898899988822"),
             lastMessage:LastMessage(message: "hi", isMy: false),
                             chatLogo: nil),
        Chat(companion: User(uuid: UUID(),
                             name: "User3452",
                             email: "zzq@mail.ru",
                             phone: "89995553535"),
             lastMessage:LastMessage(message: "Вам повестка", isMy: false),
                             chatLogo: nil),
        Chat(companion: User(uuid: UUID(),
                             name: "Военком",
                             email: "sddd@mail.ru",
                             phone: "900"),
             lastMessage:LastMessage(message: "не гасись", isMy: false),
                             chatLogo: nil),
        Chat(companion: User(uuid: UUID(),
                             name: "Ment_s_lubaynki",
                             email: "dps@mail.ru",
                             phone: "02"),
             lastMessage:LastMessage(message: "open the door", isMy: false),
                             chatLogo: nil),
        Chat(companion: User(uuid: UUID(),
                             name: "Pavel(2)",
                             email: "smka@mail.ru",
                             phone: "898899988822"),
             lastMessage:LastMessage(message: "pamagiti", isMy: true),
                             chatLogo: nil),
    ]
}
