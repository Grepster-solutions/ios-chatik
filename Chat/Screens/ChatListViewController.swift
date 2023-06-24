//
//  ChatListViewController.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import UIKit

protocol ChatListView: AnyObject {
    
    // MARK: - protocol
    
    func setTableService(_ tableService: ChatListTableService)
    func reloadData()
    
}

class ChatListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: ChatListPresenter
    
    private let tableView = UITableView()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Init
    
    init(presenter: ChatListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        setNavBarButton()
        
        title = "Список чатов"
        
        tableView.registerCell(type: ChatListCell.self)
        presenter.start()
    }
    
    
    // MARK: - Private Methods
    
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
    
    private func setNavBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: plusButton)
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapPlusButton() {
        presenter.didTapPlusButton()
    }
    
}

extension ChatListViewController: ChatListView {
    
    // MARK: - ChatListView
    
    func setTableService(_ tableService: ChatListTableService) {
        tableView.dataSource = tableService
        tableView.delegate = tableService
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}

