//
//  ChatPresenter.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import UIKit

class ChatPresenter {
    
    // MARK: - Properties
    
    weak var view: ChatViewController?
    var chatList = [Chat]()
    
    
    // MARK: - Methods
    
    func getChatList() {
        ChatService.getChatList { [weak view, weak self] chatList in
            guard let view else { return }
            guard let self else { return }
            self.chatList = chatList
            view.tableView.reloadData()
            
            self.checkChatsCount(chatList: chatList)
        }
    }
    
    func configure(cell: ChatListCell, indexPath: IndexPath) {
        let chat = chatList[indexPath.row]
        cell.setup(message: chat.lastMessage?.message,
                   time: nil,
                   name: chat.companions.first?.name ?? "",
                   logoUrl: chat.chatLogo)
    }
    
    func presentCompanionsView() {
        let presenter = CompanionsPresenter()
        let vc = CompanionsViewController(presenter: presenter)
        presenter.view = vc
        view?.present(vc, animated: true)
    }
    
    
    // MARK: - Private methods
    
    private func checkChatsCount(chatList: [Chat]) {
        if chatList.count == 0 {
            view?.showEmptyView(isShow: true)
        }
    }
}
