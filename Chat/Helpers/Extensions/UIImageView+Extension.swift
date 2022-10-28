//
//  UIImageView+Extension.swift
//  Chat
//
//  Created by Дарья on 26.10.2022.
//

import UIKit

extension UIImageView {
    func setImage(from path: String?) {
        guard let path = path else { return }
        
//        NetworkService.loadImage(fromPath: path) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                self.image = UIImage(data: data)
//            case .failure(let error):
//                print("error in setImage: ", error.localizedDescription)
//            }
//        }
    }
    
}


