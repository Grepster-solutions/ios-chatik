//
//  ChatViewController.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import UIKit

class ChatViewController: UIViewController {

    private let mockChatList = Chat.mock
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        setupLayout()
        
        tableView.register(ChatListCell.self, forCellReuseIdentifier: "ChatListCell")
        tableView.dataSource = self
         
    }
    
    
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("asdasd numberOfRowsInSection")
        return mockChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell") as? ChatListCell else {
            return UITableViewCell()
        }
        let chat = mockChatList[indexPath.row]
        cell.setup(message: chat.lastMessage?.message, time: nil, name: chat.companion.name, logoUrl: chat.chatLogo)
        return cell
    }
        
}

