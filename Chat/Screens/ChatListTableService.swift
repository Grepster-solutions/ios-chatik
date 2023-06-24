//
//  ChatListTableService.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import UIKit


final class ChatListTableService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var chatList = [Chat]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: ChatListCell.self) else {
            return UITableViewCell()
        }
        let chat = chatList[indexPath.row]
        cell.setup(message: chat.lastMessage?.text,
                   time: nil,
                   name: chat.companions.first?.name ?? "",
                   logoUrl: chat.chatLogo)
        return cell
    }
    
}
