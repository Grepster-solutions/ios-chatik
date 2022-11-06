//
//  MessagesService.swift
//  Chat
//
//  Created by Дарья on 04.11.2022.
//

import UIKit

class MessagesService {

    private static let factory = RequestFactory()
    private static var messagesFactory: MessagesRequestFactory?
    
    private static func sendRequest<T>(
        modelType: T.Type,
        requestOptions: MessagesRequestRouter,
        completion: @escaping (Result<T, Error>) -> Void) where T : Codable {
        messagesFactory = factory.makeMessagesFactory()
        messagesFactory?.sendRequest(modelType: modelType, requestOptions: requestOptions, completion: { result in
            completion(result)
        })
    }
    
    private static func sendRequest(
        requestOptions: MessagesRequestRouter,
        completion: @escaping (Result<Bool, Error>) -> Void) {
        messagesFactory = factory.makeMessagesFactory()
        messagesFactory?.sendRequest(requestOptions: requestOptions, completion: { result in
            completion(result)
        })
    }
    
    static func postMessage(chatId: String, text: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let parameters: [String: Any] = ["chat_uuid": chatId,
                                         "text": text]
        sendRequest(requestOptions: .postMessage(parameters: parameters)) { result in
            completion(result)
        }
    }
    
    static func getMessagesList(chatId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let parameters: [String: Any] = ["chat_uuid": chatId]
        sendRequest(requestOptions: .getMessageList(parameters: parameters)) { result in
            completion(result)
        }
    }
    
    static func getCompanions(completion: @escaping (Result<Companions, Error>) -> Void) {
        sendRequest(modelType: Companions.self, requestOptions: .getCompanions) { result in
            completion(result)
        }
    }
}



