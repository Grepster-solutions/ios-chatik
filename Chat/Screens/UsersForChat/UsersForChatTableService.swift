//
//  UsersForChatTableService.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import UIKit


final class UsersForChatTableService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var users = [User]()
    var onUserSelected: Closure<UUID>?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: UsersForChatItemCell.self),
                let user = users[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.setup(with: UsersForChatItemCell.Model(userName: user.name))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = users[safe: indexPath.row] else { return }
        onUserSelected?(user.uuid)
    }
    
}
