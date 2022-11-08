//
//  CompanionsViewController.swift
//  Chat
//
//  Created by Дарья on 06.11.2022.
//

import UIKit
import SnapKit

class CompanionsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let presenter: CompanionsPresenter
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CompanionsCell.self, forCellReuseIdentifier: CompanionsCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Init
    
    init(presenter: CompanionsPresenter) {
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
        navigationItem.title = "Все пользователи"
        
        addSubview()
        makeConstraints()
        
        presenter.getCompanions()
    }
    
    
    // MARK: - Private methods
    
    private func addSubview() {
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


    // MARK: - UITableViewDataSource, UITableViewDelegate

extension CompanionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.companions?.companions.count ?? 0
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanionsCell.identifier) as? CompanionsCell else {
            return UITableViewCell()
        }
        presenter.configure(cell: cell, indexPath: indexPath)
        return cell
    }
    
    didSe
}

