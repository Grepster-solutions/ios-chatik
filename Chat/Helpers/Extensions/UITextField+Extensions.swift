//
//  UITextField+Extensions.swift
//  Chat
//
//  Created by Дарья on 28.10.2022.
//

import UIKit
import SnapKit

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setUnderLine() {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
