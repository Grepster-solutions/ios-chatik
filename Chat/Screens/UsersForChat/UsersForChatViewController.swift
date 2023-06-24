//
//  UsersForChatViewController.swift
//  Chat
//
//  Created by Vladislav on 24.06.2023.
//

import UIKit


protocol UsersForChatView: UIViewController {
    
    // MARK: - Protocol
    
    func setTableService(_ tableService: UsersForChatTableService)
    func reloadData()
    
}

final class UsersForChatViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: UsersForChatPresenter
    
    private let tableView = UITableView()
    
    
    // MARK: - Init
    
    init(presenter: UsersForChatPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(type: UsersForChatItemCell.self)
        setupLayout()
        presenter.start()
    }
    
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
}

extension UsersForChatViewController: UsersForChatView {
    
    // MARK: - UsersForChatView
    
    func setTableService(_ tableService: UsersForChatTableService) {
        tableView.delegate = tableService
        tableView.dataSource = tableService
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}
