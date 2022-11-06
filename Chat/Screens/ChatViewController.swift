//
//  ChatViewController.swift
//  Chat
//
//  Created by Павел on 29.10.2022.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: ChatPresenter
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChatListCell.self, forCellReuseIdentifier: ChatListCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private(set) lazy var noChatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Напишите свое первое\nсообщение"
        label.numberOfLines = 2
        label.textColor = UIColor(named: .darkBlue)
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - Init
    
    init(presenter: ChatPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Все чаты"
        let newChatButton = UIBarButtonItem(title: "+",
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapNewChatButton))
        newChatButton.tintColor = UIColor(named: .darkBlue)
        navigationItem.rightBarButtonItem = newChatButton
        
        addSubview()
        makeConstraints()
        
        presenter.getChatList()
    }
    
    
    // MARK: - Methods
    
    func showEmptyView(isShow: Bool) {
        noChatsLabel.isHidden = !isShow
    }
    
    
    // MARK: - Private methods
    
    private func addSubview() {
        view.addSubview(tableView)
        view.addSubview(noChatsLabel)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        noChatsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapNewChatButton() {
        presenter.presentCompanionsView()
    }
}


    // MARK: - UITableViewDataSource, UITableViewDelegate

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier) as? ChatListCell else {
            return UITableViewCell()
        }
        presenter.configure(cell: cell, indexPath: indexPath)
        return cell
    }
}

