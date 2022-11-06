//
//  MessageListPresenter.swift
//  Chat
//
//  Created by Дарья on 02.11.2022.
//

import UIKit

class MessageListPresenter {
    
    // MARK: - Properties
    
    weak var view: MessageListViewController?
    let mockMessageList = MessageList.mock
    
    
    // MARK: - Methods
    
    func configure(cell: IncomingMessageCell, indexPath: IndexPath) {
        let messageModel = mockMessageList.massage[indexPath.row]
        cell.display(model: messageModel)
    }
    
    func configure(cell: OutcomingMessageCell, indexPath: IndexPath) {
        let messageModel = mockMessageList.massage[indexPath.row]
        cell.display(model: messageModel)
    }
}


