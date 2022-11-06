//
//  CompanionsPresenter.swift
//  Chat
//
//  Created by Дарья on 06.11.2022.
//

import UIKit

class CompanionsPresenter {
    
    // MARK: - Properties
    
    weak var view: CompanionsViewController?
    var companions: Companions?
    
    
    // MARK: - Methods
    
    func getCompanions() {
        MessagesService.getCompanions { [weak self, weak view] result in
            guard let self else { return }
            guard let view else { return }
            switch result {
            case .success(let data):
                self.companions = data
                view.tableView.reloadData()
            case .failure(let error):
                print("error in getCompanions: ", error)
            }
        }
    }
    
    func configure(cell: CompanionsCell, indexPath: IndexPath) {
        guard let companion = companions?.companions[indexPath.row] else { return }
        cell.display(model: companion)
    }
}

