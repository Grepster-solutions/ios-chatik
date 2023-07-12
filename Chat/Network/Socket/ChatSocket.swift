//
//  ChatSocket.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import SocketIO

final class ChatSocket {
    
    // MARK: - Properties
    
    var onMessagesUpdated: Closure<[Message]>?
    var onNewMessage: Closure<Message>?
    
    private let chatUuid: UUID
    private let manager = SocketManager(socketURL: URL(string: NetworkConstants.domain)!)
    private lazy var socket = manager.socket(forNamespace: "/\(NetworkConstants.apiVersion)/messages")
    
    
    // MARK: - Init
    
    init(chatUuid: UUID) {
        self.chatUuid = chatUuid
    }
    
    deinit {
        socket.disconnect()
    }
    
    
    // MARK: - Interface
    
    func start() {
        socket.on("messages_list") { [weak self] data, _ in
            guard let self else { return }
            if let json = data.first as? String,
               let jsonData = json.data(using: .utf8) {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([Message].self, from: jsonData)
                    self.onMessagesUpdated?(result)
                } catch {
                    self.onMessagesUpdated?([])
                }
            } else {
                
            }
        }
        
        socket.on("chat_on_add") { [weak self] data, _ in
            guard let self else { return }
            if let json = data.first as? String,
                let jsonData = json.data(using: .utf8) {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Message.self, from: jsonData)
                    self.onNewMessage?(result)
                } catch {
                    return
                }
            }
        }
        
        socket.on(clientEvent: .connect) { [weak self, weak socket] _, _ in
            guard
                let token = AuthController.getToken(),
                let self,
                let json = try? JSONEncoder().encode(["chat_uuid": self.chatUuid.uuidString, "token": token])
            else { return }
            socket?.emit("join_room", json)
        }
        
        socket.connect()
    }
    
    func sendNewMessage(message: String) {
        guard
            let token = AuthController.getToken(),
            let json = try? JSONEncoder().encode(["chat_uuid": self.chatUuid.uuidString,
                                                  "token": token,
                                                  "message": message])
        else { return }
        socket.emit("new_message", json)
    }
    
}
