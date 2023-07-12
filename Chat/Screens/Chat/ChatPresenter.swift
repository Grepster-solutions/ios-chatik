//
//  ChatPresenter.swift
//  Chat
//
//  Created by Дарья on 02.11.2022.
//

import Foundation


protocol ChatPresenter {
    
    // MARK: - Protocol
    
    func start()
    
}

final class ChatPresenterImpl {
    
    // MARK: - Properties
    
    weak var view: ChatView?
    
    private let tableService = ChatTableService()
    private let chatUuid: UUID
    private lazy var chatSocket = ChatSocket(chatUuid: chatUuid)
    
    private var messagePanelText: String?
    
    
    // MARK: - Init
    
    init(chatUuid: UUID) {
        self.chatUuid = chatUuid
    }
    
}

extension ChatPresenterImpl: ChatPresenter {
    
    // MARK: - ChatPresenter
    
    func start() {
        view?.setTableService(tableService)
        
        chatSocket.onNewMessage = { [weak self] message in
            guard let self else { return }
            self.tableService.messages.append(message)
            self.view?.reloadData()
        }
        
        chatSocket.onMessagesUpdated = { [weak self] messages in
            guard let self else { return }
            self.tableService.messages = messages
            self.view?.reloadData()
        }
        
        chatSocket.start()
    }
    
}

extension ChatPresenterImpl: MessagePanelDelegate {
    
    // MARK: - MessagePanelDelegate
    
    func didChangeText(newText: String) {
        messagePanelText = newText.isNotEmpty ? newText : nil
    }
    
    func didTapSendButton() {
        guard let messagePanelText else { return }
        chatSocket.sendNewMessage(message: messagePanelText)
    }
    
}
