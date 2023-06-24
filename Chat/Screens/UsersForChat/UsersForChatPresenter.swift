//
//  UsersForChatPresenter.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import Foundation


protocol UsersForChatDelegate: AnyObject {
    
    // MARK: - Delegate
    
    func didSelectUser(with uuid: UUID)
    
}

protocol UsersForChatPresenter {
    
    // MARK: - Protocol
    
    func start()
    
}

final class UsersForChatPresenterImpl {
    
    // MARK: - Properties
    
    weak var view: UsersForChatView?
    weak var delegate: UsersForChatDelegate?
    
    private let tableService = UsersForChatTableService()
    
    
}

extension UsersForChatPresenterImpl: UsersForChatPresenter {
    
    // MARK: - UsersForChatPresenter
    
    func start() {
        bindTableCallbacks()
        view?.setTableService(tableService)
        
        let requestRouter = UserRequestRouter.usersForChat
        NetworkService.makeRequest(requestRouter: requestRouter,
                                   modelType: [User].self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let users):
                self.tableService.users = users
                self.view?.reloadData()
            case .failure:
                break
            }
        }
    }
    
    private func bindTableCallbacks() {
        tableService.onUserSelected = { [weak view] uuid in
            view?.dismiss(animated: true) {
                self.delegate?.didSelectUser(with: uuid)
            }
        }
    }
    
}
