//
//  ChatListPresenter.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import Foundation


protocol ChatListPresenter {
    
    // MARK: - Protocol
    
    func start()
    
    func didTapPlusButton()
    func didTapLogout()
    
}

final class ChatListPresenterImpl {
    
    // MARK: - Properties
    
    weak var view: ChatListView?

    private let router: ChatListRouter
    
    private let tableService = ChatListTableService()
    private var chatList = [Chat]()
    
    
    // MARK: - Init
    
    init(router: ChatListRouter) {
        self.router = router
    }
    
    
    // MARK: - Private Methods
    
    private func updateView() {
        tableService.chatList = chatList
        view?.reloadData()
    }
    
}

extension ChatListPresenterImpl: ChatListPresenter {
    
    // MARK: - ChatListPresenter
    
    func start() {
        view?.setTableService(tableService)
        tableService.onChatSelect = { [weak router] chat in
            router?.openChat(with: chat.uuid)
        }
        
        reloadChats()
    }
    
    func didTapPlusButton() {
        router.openUsersForChat(delegate: self)
    }
    
    private func reloadChats() {
        let requestRouter = ChatsRequestRouter.list
        NetworkService.makeRequest(requestRouter: requestRouter,
                                   modelType: ChatListResult.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let chatListResult):
                self.chatList = chatListResult.chatList
                self.updateView()
            case .failure:
                break
            }
        }
    }
    
}

extension ChatListPresenterImpl: UsersForChatDelegate {
    
    // MARK: - UsersForChatDelegate
    
    func didSelectUser(with uuid: UUID) {
        let requestRouter = ChatsRequestRouter.create(companionUUIDs: [uuid])
        NetworkService.makeRequest(requestRouter: requestRouter,
                                   modelType: Chat.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let chat):
                self.reloadChats()
                self.router.openChat(with: chat.uuid)
            case .failure(let error):
                print("Huge mistake: \(error.localizedDescription)")
            }
        }
    }
    
    func didTapLogout() {
        AuthController.logout()
    }
    
}
