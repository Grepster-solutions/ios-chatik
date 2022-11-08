//
//  MainViewController.swift
//  Chat
//
//  Created by Дарья on 07.11.2022.
//

import UIKit
import SnapKit

class MainViewController: UITabBarController {
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setTabBarAppearance()
    }
    
    
    // MARK: - Private methods
    
    private func generateTabBar() {
        let chatPresenter = ChatPresenter()
        let chatVC = ChatViewController(presenter: chatPresenter)
        chatPresenter.view = chatVC
        viewControllers = [
            createTabBarItem(tabBarTitle: nil, tabBarImage: UIImage(systemName: "person"), viewController: ProfileViewController()),
            createTabBarItem(tabBarTitle: nil, tabBarImage: UIImage(systemName: "message"), viewController: chatVC),
            createTabBarItem(tabBarTitle: nil, tabBarImage: UIImage(systemName: "gearshape"), viewController: ProfileViewController())
        ]
    }
    
    func createTabBarItem(tabBarTitle: String?, tabBarImage: UIImage?, viewController: UIViewController) -> UINavigationController {
            let navCont = UINavigationController(rootViewController: viewController)
            navCont.tabBarItem.title = tabBarTitle
            navCont.tabBarItem.image = tabBarImage
            return navCont
        }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bazierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX,
                                                          y: tabBar.bounds.minY - positionOnY,
                                                          width: width,
                                                          height: height),
                                      cornerRadius: height / 2)
        
        roundLayer.path = bazierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.white.cgColor
        tabBar.tintColor = UIColor(named: .purple)
        tabBar.unselectedItemTintColor = UIColor(named: .purple).withAlphaComponent(0.7)
        
    }
}
