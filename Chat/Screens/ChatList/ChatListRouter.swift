//
//  ChatListRouter.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import UIKit


protocol ChatListRouter: AnyObject {
    
    // MARK: - Protocol
    
    func openUsersForChat(delegate: UsersForChatDelegate)
    func openChat(with chatUuid: UUID)
    
}

final class ChatListRouterImpl: ChatListRouter {
    
    // MARK: - Properties
    
    weak var view: UIViewController?
    
    
    // MARK: - Interface
    
    func openUsersForChat(delegate: UsersForChatDelegate) {
        let presenter = UsersForChatPresenterImpl()
        let vc = UsersForChatViewController(presenter: presenter)
        presenter.view = vc
        presenter.delegate = delegate
        view?.present(vc, animated: true)
    }
    
    func openChat(with chatUuid: UUID) {
        let presenter = ChatPresenterImpl(chatUuid: chatUuid)
        let vc = ChatViewController(presenter: presenter)
        presenter.view = vc
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
