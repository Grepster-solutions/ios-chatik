//
//  ChatService.swift
//  Chat
//
//  Created by Павел on 30.10.2022.
//

import Foundation
 
enum ChatService {
    
    static func getChatList(completion: @escaping ([Chat]) -> Void) {
        guard let url = URL(string: Constants.baseUrl + "/chat_list"), let token = AuthController.getToken() else {
            return
        }
        print("zzz ", token)
        let headers = ["Content-Type": "application/json",
                       "x-access-token": "\(token)"]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("error in getChatList: ", error.localizedDescription)
                    completion([])
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let chatList = try decoder.decode(ChatListResult.self, from: data)
                        print("success in getChatList")
                        completion(chatList.chatList)
                    } catch {
                        print("error in getChatList: ", error.localizedDescription)
                        completion([])
                    }
                } else {
                    completion([])
                }
            }
        }
        dataTask.resume()
    }
}

