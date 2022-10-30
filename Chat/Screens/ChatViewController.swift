//
//  ChatViewController.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import UIKit

class ChatViewController: UIViewController {

    private var chatList = [Chat]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        setupLayout()
        
        tableView.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.identifier)
        tableView.dataSource = self
        ChatService.getChatList { [weak self] chatList in
            self?.chatList = chatList
            self?.tableView.reloadData()
        }
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
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier) as? ChatListCell else {
            return UITableViewCell()
        }
        let chat = chatList[indexPath.row]
        cell.setup(message: chat.lastMessage?.message, time: nil, name: chat.companions.first?.name ?? "", logoUrl: chat.chatLogo)
        return cell
    }
        
}

