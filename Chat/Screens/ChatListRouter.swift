//
//  ChatListRouter.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import UIKit


protocol ChatListRouter {
    
    // MARK: - Protocol
    
    func openUsersForChat(delegate: UsersForChatDelegate)
    
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
    
}
