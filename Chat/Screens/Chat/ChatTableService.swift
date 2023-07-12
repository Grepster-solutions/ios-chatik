//
//  ChatTableService.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import Foundation
import UIKit


final class ChatTableService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var messages = [Message]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = messages[safe: indexPath.row] else { return UITableViewCell() }
        
        if let author = message.author,
           let currentUser = UserDefaultsManager.currentUser {
            if currentUser.uuid == author.uuid {
                guard let cell = tableView.dequeueCell(withType: OutcomingMessageCell.self) else { return UITableViewCell() }
                cell.setup(model: message)
                return cell
            } else {
                guard let cell = tableView.dequeueCell(withType: IncomingMessageCell.self) else {
                    return UITableViewCell()
                }
                cell.setup(model: message)
                return cell
            }
        } else {
            guard let cell = tableView.dequeueCell(withType: SystemMessageCell.self) else { return UITableViewCell() }
            return cell
        }
    }
    
}
