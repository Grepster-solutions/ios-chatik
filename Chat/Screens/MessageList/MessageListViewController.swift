//
//  MessageListViewController.swift
//  Chat
//
//  Created by Дарья on 02.11.2022.
//

import UIKit
import SnapKit

enum MessageType: String {
    case incoming = "incoming"
    case outcoming = "outcoming"
    case system = "system"
}

enum MessageContentType {
    case text
    case photo
    case video
    case audio
}

class MessageListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: MessageListPresenter
    private var messageType: MessageType?
    private var messageContentType: MessageContentType?
    
    private(set) lazy var backgroundView = UIView()
    private weak var gradientLayer: CAGradientLayer?
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IncomingMessageCell.self, forCellReuseIdentifier: IncomingMessageCell.identifier)
        tableView.register(OutcomingMessageCell.self, forCellReuseIdentifier: OutcomingMessageCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    // MARK: - Init
    
    init(presenter: MessageListPresenter) {
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
        
        addSubviews()
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer?.frame = view.bounds
        gradientLayer = backgroundView.makeGradient(colors: [UIColor(named: .purple).withAlphaComponent(0.4),
                                                             UIColor(named: .darkBlue).withAlphaComponent(0.4)],
                                                    locations: [0.0, 1.0],
                                                    startPoint: CGPoint(x: 0, y: 0),
                                                    endPoint: CGPoint(x: 1, y: 1))
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(tableView)
    }
    
    private func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension MessageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageType = presenter.messageList[indexPath.row].type
        switch messageType {
        case "incoming":
            self.messageType = .incoming
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IncomingMessageCell.identifier) as? IncomingMessageCell else {
                return UITableViewCell()
            }
            presenter.configure(cell: cell, indexPath: indexPath)
            return cell
        case "outcoming":
            self.messageType = .outcoming
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OutcomingMessageCell.identifier) as? OutcomingMessageCell else {
                return UITableViewCell()
            }
            presenter.configure(cell: cell, indexPath: indexPath)
            return cell
        case "system":
            break
        default:
            break
        }
        
        return UITableViewCell()
    }
}

