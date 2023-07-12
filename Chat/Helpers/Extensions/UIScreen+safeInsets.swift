//
//  UIScreen+safeInsets.swift
//  Chat
//
//  Created by Vladislav on 25.06.2023.
//

import UIKit

extension UIScreen {
    
    static var safeInsets: UIEdgeInsets {
        guard let rootView = UIApplication.shared.keyWindow else { return UIEdgeInsets.zero }
        return rootView.safeAreaInsets
    }
    
}
